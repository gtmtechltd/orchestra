require 'trollop'
require 'orchestra/configuration'
require 'orchestra/logging'

include Log4r

module Orchestra

  class Conductor

    include Logging

    attr_reader :configuration

    def initialize

      @configuration = Configuration.new
    end

    def perform symphony
      @configuration.options.merge symphony[:options]

      puts "\nThe conductor has entered the stage. ** APPLAUSE **\n"

      if symphony[:options][:listtasks]
        listtasks
        return
      end

    end

    def listtasks
      helptext = "Available tasks\n\n"
      @configuration.namespaces.each do |namespace|
        logger.debug "Added new namespace (#{namespace.id})"
        namespace.tasks.each do |task|
          helptext += "#{task.summary}\n" unless task.summary.nil?
        end
      end
      logger.info helptext
    end

  end
end
