require 'spec_helper'

describe StompActors::Client do
  let(:host) { '127.0.0.1' }
  let(:port) { 61623 }

  before do

    class MyActor
      include Celluloid
      include StompActors::Client

      def connect_opts
        {
          hosts: [{ host: '127.0.0.1', port: 61623 }]
        }
      end
    end

    Celluloid.shutdown
    Celluloid.boot

    @server_thread = StompDroid::Server.start(host, port)
    sleep 0.1 # let start
  end

  after do
    @server_thread.terminate
  end

  it "should connect and disconnect" do
    actor = MyActor.new

    actor.connect
    actor.client.open?.should be_true

    actor.disconnect
    actor.client.open?.should be_false
  end

end
