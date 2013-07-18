require 'orchestra/logging'
require 'orchestra/DSL'

module Orchestra

  class Role < DSL

    include Logging

    attr_reader :id
    attr_reader :tasks

    def initialize id, *args
      @id = id
      @servers = []
      @options = {}
      logger.debug "Added new role (#{id})"
    end

    def option key, value
      @options[ key ] = value
    end

  end
end
