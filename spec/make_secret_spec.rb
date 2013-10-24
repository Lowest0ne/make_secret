require 'rspec'
require './lib/make_secret.rb'

describe MakeSecret do

  it 'generates a value given a key' do
    MakeSecret::Value.for(:key).should_not == nil
  end

  it 'generates a different value for different key' do
    first = MakeSecret::Value.for(:first)
    second = MakeSecret::Value.for(:second)
    first.should_not == second
  end

  it 'generates the same value for the same key' do
    value = MakeSecret::Value.for( :key )
    value.should == MakeSecret::Value.for( :key )
  end

  describe 'persistsing data' do
    let ( :file_name ){ './spec/file.json' }
    after { File.delete( file_name ) }

    it 'will create a file if it does not exist' do
      File.exists?( file_name ).should == false
      MakeSecret::Value.for( :key , file_name )
      File.exists?( file_name ).should == true
    end

    it 'saves the data in the file' do
      first = MakeSecret::Value.for(:first, file_name )
      second = MakeSecret::Value.for(:second, file_name )

      file_str = File.read( file_name )
      file_str.scan( /first/ ).should_not be_empty
      file_str.scan( /second/ ).should_not be_empty
      file_str.scan( first ).should_not be_empty
      file_str.scan( second ).should_not be_empty
    end

    it 'can retrieve the data' do
      value = MakeSecret::Value.for( :key, file_name )
      value.should == MakeSecret::Value.for( :key, file_name )
    end

    it 'differentiates between persisting data and data in memory' do
      value = MakeSecret::Value.for(:key)
      value.should_not == MakeSecret::Value.for( :key, file_name )
    end

    describe 'from a file that exists' do
      before { @kept_value = MakeSecret::Value.for( :keep, file_name  ) }

      it 'does not loose the original values' do
        MakeSecret::Value.for( :new_key, file_name )
        @kept_value.should == MakeSecret::Value.for( :keep, file_name )
      end

    end

  end

end
