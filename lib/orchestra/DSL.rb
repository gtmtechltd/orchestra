require 'orchestra/logging'
require 'orchestra/abort_error'

module Orchestra

  class DSL

    include Logging

    def method_missing(method_name, *args, &block)

      try_class_name = "Plugins::#{camel_case method_name.to_s}Plugin"

      puts "Trying #{try_class_name}"
      begin
        puts "-> require \"orchestra/plugins/#{method_name.to_s}_plugin\""
        require "orchestra/plugins/#{method_name.to_s}_plugin" unless class_exists? try_class_name
      rescue LoadError
        logger = Logging.logger_for(self.class.name)
        logger.warn "\"#{method_name}\" is not part of the DSL (#{caller.first})"
        raise AbortError
      end

      puts "Now testing again for #{try_class_name}"
        puts Module.const_get(try_class_name) + "asd"
      if class_exists? try_class_name

        @objects = {} unless @objects
        @objects[ method_name ] = [] unless @objects.key? method_name
        @objects[ method_name ] << Module.const_get(try_class_name).from_block( *args, &block )

      else

        a = Plugins::ExecutePlugin.new
        puts "#{a}"
        puts "SOMETHING WENT WRONG #{try_class_name}"

      end

    end

    def class_exists?(class_name)
      begin
        klass = Module.const_get(class_name)
        return klass.is_a?(Class)
      rescue NameError
        return false
      end
    end

    def camel_case some_string
      return some_string if some_string !~ /_/ && some_string =~ /[A-Z]+.*/
      some_string.split('_').map{|e| e.capitalize}.join
    end


    def self.from_rbfile(filename, id)

      file = File.open(filename, "rb")
      contents = file.read

      dsl = new id
      dsl.instance_eval(File.read(filename), filename)
      dsl
    end

    def self.from_block(id, *args, &block)

      dsl = new(id, *args)
      dsl.instance_eval &block if block
      dsl

    end

  end

end