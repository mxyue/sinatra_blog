require './app'
require './apis/api'



run Rack::Cascade.new [API, Sinatra::Application]