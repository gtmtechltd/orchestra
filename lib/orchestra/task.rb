module Orchestra
  class Task

    attr_reader :id, :user

    def initialize id, *args
      @id = id
      @user ||= options[:user]
      @method ||= options[:method]
      @description ||= options[:description]
      @namespace ||= options[:namespace]
      @private ||= options[:private]
    end

    # def method_missing
    #   Call plugin if exists
    # end

    def summary
      if @private
        nil
      elsif @namespace.id == "default"
        "#{@id} - #{@description}"
      else
        "#{@namespace.id}#{@id} - #{@description}"
      end
    end

  end
end
