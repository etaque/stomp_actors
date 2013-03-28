require 'spec_helper'

describe StompActors::Producer do
  let(:host) { '127.0.0.1' }
  let(:port) { 61623 }
  let(:queue) { "/queue/foo" }
  let(:message_dir) { 'tmp/messages' }

  before do
    class MyProducer < StompActors::Producer
      def uri
        "stomp://127.0.0.1:61623"
      end
      def queue
        '/queue/foo'
      end
    end

    @server_thread = StompDroid::Server.start(host, port, queue_name: queue, sent_message_dir: message_dir)
    sleep 0.1 # let start
  end

  after do
    @server_thread.terminate
    FileUtils.rm(Dir.glob("#{message_dir}/*.msg"))
  end

  it "should send message" do
    producer = MyProducer.new
    expect {
      producer.emit("message")
      sleep 0.5
    }.to change { Dir["#{message_dir}/*.msg"].to_a.length }.by(1)
  end
end

