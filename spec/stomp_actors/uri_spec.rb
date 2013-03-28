require 'spec_helper'

describe StompActors::URI do
  subject { StompActors::URI.new(conf).generate }

  context "simple conf" do
    let(:conf) { {
      host: "127.0.0.1",
      port: "61613",
      user: "franck",
      password: "sinatra"
    } }

    it { should == "stomp://franck:sinatra@127.0.0.1:61613" }
  end

  context "failover conf" do
    let(:conf) { [
      {
        host: "127.0.0.1",
        port: "61613",
        user: "franck",
        password: "sinatra"
      }, {
        host: "127.0.0.2",
        port: "61613",
        user: "franck",
        password: "sinatra"
      }
    ] }

    it { should == "failover:(stomp://franck:sinatra@127.0.0.1:61613,stomp://franck:sinatra@127.0.0.2:61613)" }
  end
end
