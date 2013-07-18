require 'orchestra/logging'
require 'orchestra/DSL'

module Orchestra

  class Server < DSL

    include Logging

    attr_reader :id
    attr_accessor :ssh_user

    def initialize id, *args
      @id = id
      @options = {}
      logger.debug "Added new server (#{id})"
    end

    # def method_missing
    #   Call plugin if exists
    # end

    def option key, value
      @options[ key ] = value
    end

  end
end
