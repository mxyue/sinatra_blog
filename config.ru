require './app'
require './apis/api'
# Dir.glob('./apis/entities/*.rb').each { |r| require_relative r }



run Rack::Cascade.new [API, Sinatra::Application]