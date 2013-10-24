require 'securerandom'
require 'json'

module MakeSecret

  class Value

    def self.for( key, file_name = nil )
      file_name ? from_file( key, file_name ) : from_memory( key )
    end

    private
    def self.from_file( key, file_name )
      file_str = '{}'
      file_str = File.read( file_name ) if File.exists?( file_name )
      json_obj = JSON.parse( file_str, symbolize_names: true )

      if json_obj[key]
        json_obj[key]
      else
        value = json_obj[key] = SecureRandom.hex( 64 )
        File.write( file_name, json_obj.to_json )
        value
      end

    end

    def self.from_memory( key )
      @keys ||= {}
      @keys[key] || @keys[key] = SecureRandom.hex( 64 )
    end

  end

end
