require 'bundler'

require 'celluloid'
require 'stomp_droid'
require 'stomp'
require 'pry'

require 'stomp_actors'

logfile = File.open(File.expand_path("../../log/test.log", __FILE__), 'a')
Celluloid.logger = Logger.new(logfile)

RSpec.configure do |config|
  config.before :each do
  end
end



