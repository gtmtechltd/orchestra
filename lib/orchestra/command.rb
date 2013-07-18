require 'orchestra/logging'

module Orchestra

  class Command

    include Logging
    
    attr_reader :user
    attr_reader :method
    
  end
end
