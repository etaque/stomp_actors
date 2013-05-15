module StompActors
  class Consumer
    include Celluloid
    include Celluloid::Logger

    include Client

    attr_accessor :subscription_id

    finalizer :cleanup

    def initialize
      async.start
    end

    def start
      connect
      subscribe
    end

    def subscribe
      me = current_actor

      @subscription_id = client.subscribe(queue, subscribe_opts) do |msg|
        me.receive(msg)
      end
    end

    def subscribe_opts
      {}
    end

    def ack(msg)
      client.ack(msg)
    end

    def cleanup
      unsubscribe
      disconnect
    end

    def unsubscribe
      client.unsubscribe(@subscription_id) if @subscription_id
    end
  end
end

