require 'spec_helper'

describe StompActors::Consumer do
  let(:host) { '127.0.0.1' }
  let(:port) { 61623 }
  let(:queue) { "/queue/foo" }
  let(:msg) { "something" }

  before do
    class MyConsumer < StompActors::Consumer
      attr_reader :queue

      def initialize(host, port, queue)
        @host = host
        @port = port
        @queue = queue
        super()
      end

      def uri
        "stomp://#{@host}:#{@port}"
      end

      def receive(msg)
        do_something
        ack(msg)
      end

      def do_something; end
    end

    @server_thread = StompDroid::Server.start(host, port, queue_name: queue, message: msg)
    sleep 0.1 # let start
  end

  after do
    @server_thread.terminate
  end

  it "should subscribe, handle and ack message on connect" do
    MyConsumer.any_instance.should_receive(:do_something)
    consumer = MyConsumer.new(host, port, queue)
    sleep 0.1
  end

  it "should unsubscribe on finalize" do
    consumer = MyConsumer.new(host, port, queue)
    sleep 0.1
    consumer.finalize
  end
end
