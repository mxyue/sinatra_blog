require 'grape'
require 'grape-entity'
Dir.glob("#{__dir__}/entities/*.rb").each { |r| require_relative r }
Dir.glob("#{__dir__}/*.rb").each { |r| require_relative r }

class API < Grape::API
  prefix :api # set the url prefix
  format :json

  mount PostsAPI
end