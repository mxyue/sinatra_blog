require 'grape'
require 'grape-entity'
require 'unirest'
require 'database_cleaner'
require 'rack'

ENV['RACK_ENV'] = 'test'
require File.expand_path('../../apis/api.rb', __FILE__)
require File.expand_path('../../app.rb', __FILE__)


# rake["rackup -p #{@port} -E test"].invoke

server = TCPServer.new('127.0.0.1', 0)
@@port = server.addr[1]
puts "port===>#{@@port}"


RSpec.configure do |config|

  DatabaseCleaner.strategy = :transaction
  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end


  config.after(:each) do
    DatabaseCleaner.clean_with(:truncation)
  end


end

def get(url,parameters)
  puts "====----#{@@port}"
  url = url.start_with?('http') ? url : "http://0.0.0.0:#{8080}#{url}"
  Unirest.get url, parameters
end

def post(url,parameters)
  Unirest.post url, parameters
end

def put(url,parameters)
  Unirest.put url, parameters
end