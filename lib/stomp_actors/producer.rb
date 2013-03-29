module StompActors
  class Producer
    include Celluloid
    include Celluloid::Logger

    include Client

    def initialize
      async.connect
    end

    def emit(msg)
      client.send(queue, msg)
    end

    def finalize
      disconnect
    end
  end
end


