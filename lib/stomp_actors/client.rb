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
      @client = OnStomp.open(uri)

      me = current_actor

      @client.on_connection_closed do |_, _, msg|
        me.async.connection_closed(msg)
      end

      @client.on_error do |e, *_|
        me.async.broker_error(e)
      end
    end

    def connection_closed(msg)
      unless @disconnecting
        error "Connection closed: #{msg}" if respond_to?(:error)
        raise DisconnectionError.new(msg)
      end
    end

    def broker_error(e)
      error("Broker error: #{e.inspect}") if respond_to?(:error)
      raise BrokerError.new(e[:message])
    end

    def disconnect
      @disconnecting = true
      @client.disconnect if @client && @client.connected?
    end

  end
end

