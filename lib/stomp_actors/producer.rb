module StompActors
  class Producer
    include Celluloid
    include Celluloid::Logger

    include Client

    finalizer :disconnect

    def initialize
      async.connect
    end

    def emit(msg, opts = {})
      client.send(queue, msg, opts)
    end

  end
end


