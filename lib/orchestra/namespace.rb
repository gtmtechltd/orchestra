module Orchestra
  class Namespace

    attr_reader :id, :tasks

    def initialize id, *args
      @id = id
      @tasks = {}
    end

    def task task_id, *args, &block
      raise ConfigurationException, "Task defined twice: #{@id}::#{task_id}" if @tasks.key?(task_id)
      @tasks[ task_id ] = Task.new(task_id, *args)
      @tasks[ task_id ].instance_eval &block      
    end

  end
end
