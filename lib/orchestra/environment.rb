module Orchestra
  class Environment
    
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

    def server(server_name, host, options)
      servers[server_name] = options
    end
 
    def role *args
      name = args.shift

      options = {}
      options.merge args.pop if args.last.is_a(Hash)
     
      servers = args

      @roles[:name] = {:servers => servers, :options => options}
    end 

  end
end

