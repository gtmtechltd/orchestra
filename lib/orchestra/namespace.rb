require 'orchestra/logging'
require 'orchestra/task'
require 'orchestra/DSL'

module Orchestra

  class Namespace < DSL

    include Logging

    attr_reader :id
    attr_reader :tasks

    def initialize id, *args
      @id = id
      @tasks = {}
      logger.debug "Added new namespace (#{id})"
    end

    def task task_id, *args, &block
      raise ConfigurationException, "Task defined twice: #{@id}::#{task_id}" if @tasks.key?(task_id)
      @tasks[ task_id ] = Task.new(task_id, *args)
      @tasks[ task_id ].instance_eval &block      
    end

    def namespace namespace_id, *args, &block
    end

  end
end
