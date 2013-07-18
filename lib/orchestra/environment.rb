require 'orchestra/logging'
require 'orchestra/DSL'
require 'orchestra/Role'
require 'orchestra/Server'

module Orchestra

  class Environment < DSL

    include Logging
    
    attr_reader :id

    def initialize id, *args
      @id = id
      @roles = {}
      @servers = {}
      @properties = {}
    end

    def setup &block
      yield block
    end

    def property(property_name, property_value)
      properties[property_name] = property_value
    end

    def server *args, &block
      server_id = args.shift

      @servers[ server_id ] = Server.from_block( server_id, *args, &block )
    end
 
    def role *args, &block
      role_id = args.shift

      @roles[ role_id ] = Role.from_block( role_id, *args, &block )
    end 

    protected

    def servers
      @servers.values
    end



  end
end

