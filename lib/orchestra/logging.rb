require 'log4r-color'

include Log4r

Logger.global.level = ALL

ColorOutputter.new "color", {
  :colors => {
    :debug => :light_blue,
    :info => :white,
    :warn => :yellow,
    :error => :red,
    :fatal => { :color => :red, :background => :white }
  }
}

module Orchestra

  module Logging

    def logger
      @logger ||= Logging.logger_for(self.class.name)
    end

    # Use a hash class-ivar to cache a unique Logger per class:
    @loggers = {}

    class << self
      def logger_for(classname)
        @loggers[classname] ||= configure_logger_for(classname)
      end

      def configure_logger_for(classname)
        logger = Logger.new(classname).add('color')
        Logger[classname]
      end
    end

  end

end
