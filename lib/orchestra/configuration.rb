require 'orchestra/logging'
require 'orchestra/namespace'
require 'orchestra/environment'

module Orchestra

  class Configuration

    include Logging

    attr_accessor :options

    def initialize
      @environments = {}
      @namespaces = { :default => Namespace.new('default') }
      @options = {}

      load
      #read_files - instance_eval them in the context of here
    end

    def load
      Dir.glob("environments/**/*.rb").select do |filename|
        environment_id = filename.gsub(/^environments\//, '')
        environment_id.gsub!(/\//, '::')
        environment_id.gsub!(/\.rb$/, '')
        @environments[environment_id] = Environment.from_rbfile( filename, environment_id )
      end

      Dir.glob("tasks/**/*.rb").select do |filename|
        namespace_id = filename.gsub(/^tasks\//, '')
        namespace_id.gsub!(/\//, '::')
        namespace_id.gsub!(/\.rb$/, '')
        @namespaces[namespace_id] = Namespace.from_rbfile( filename, namespace_id )
      end
    end

    def namespaces
      @namespaces.values
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

