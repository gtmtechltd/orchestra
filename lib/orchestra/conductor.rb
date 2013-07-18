require 'trollop'
require 'log4r'
include Log4r

module Orchestra
  class Conductor

    attr_reader :configuration

    def initialize
      @configuration = Configuration.new
      @logger = Logger.new 'stdout'
      @logger.outputters = Outputter.stdout
    end

    def perform symphony
      @configuration.options.merge symphony[:options]

      if symphony[:options][:listtasks]
        listtasks
        return
      end

    end

    def listtasks
      helptext = "Available tasks\n\n"
      @configuration.namespaces.collect {|namespace| namespace.tasks}.each do |task|
        helptext += "#{task.summary}\n" unless task.summary.nil?
      end
      logger.info helptext
    end

  end
end
