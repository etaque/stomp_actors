module StompActors
  module Client

    class DisconnectionError < StandardError; end
    class BrokerError < StandardError; end

    def self.included(base)
      base.extend ClassMethods

      base.class_eval do
        attr_accessor :client
      end
    end

    module ClassMethods
    end

    def connect
      @client = Stomp::Client.new(connect_opts)
    end

    def disconnect
      @disconnecting = true
      @client.close if @client && @client.open?
    end

  end
end

