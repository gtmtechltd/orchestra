module Orchestra
  class Configuration

    attr_accessor :options, :namespaces

    def initialize
      @environments = {}
      @namespaces = { :default => Namespace.new }
      @options = {}

      #read_files - instance_eval them in the context of here

    end

    def environment id, *args, &setup_block
      environment_id = args.shift
      @environments[ environment_id ] = Environment.new(id, *args) unless @environments.key? environment_id
      @environments[ environment_id ].instance_eval &setup_block
    end

    def namespace id, *args, &setup_block
      namespace_id = args.shift
      @namespaces[ namespace_id ] = Namespace.new(id, *args) unless @namespaces.key? namespace_id
      @namespaces[ namespace_id ].instance_eval &setup_block
    end

    def task id, *args, &setup_block
      @namespaces[ :default ].task id, *args, &setup_block
    end
 
  end
end

