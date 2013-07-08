# StompActors

A suite of Celluloid actors to consume and produce to queues with Stomp protocol.

## Installation

Add this line to your application's Gemfile:

    gem 'stomp_actors'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install stomp_actors

## Usage

### Consumers

Inherit from `StompActors::Consumer` then define `#queue` and `#connect_opts`
values, and `#receive(msg)` method.

Define `#subscribe_opts` to customize subscription options.

Use `ack(msg)` to acknowledge message, if needed.

Example:

```ruby
class MyConsumer < StompActors::Consumer
  def connect_opts
    # stomp gem hash login, see:
    # https://github.com/stompgem/stomp#hash-login-example-usage-this-is-the-recommended-login-technique
    {
      hosts: [{ host: "127.0.0.1", port: 61613}]
    }
  end

  def queue
    "/queue/foo"
  end

  def subscribe_opts
    { ack: 'client' }
  end

  def receive(msg)
    # do something with msg
    ack(msg)
  end
end

MyConsumer.new # your actor is now subscribed and will receive messages.
```

### Producers

Inherit from `StompActors::Producer` then define `#queue` and `#connect_opts`
values.

Use `emit(msg)` to send message to the defined queue.

Example:

```ruby
class MyProducer < StompActors::Producer
  def connect_opts
    {
      hosts: [{ host: "127.0.0.1", port: 61613}]
    }
  end

  def queue
    "/queue/foo"
  end
end

p = MyProducer.new
p.emit("stuff") # message sent to queue
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
