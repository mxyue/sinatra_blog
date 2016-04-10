require 'grape'
require 'grape-entity'
require 'jwt'
Dir.glob("#{__dir__}/entities/*.rb").each { |r| require_relative r }
Dir.glob("#{__dir__}/*.rb").each { |r| require_relative r }

class API < Grape::API
  prefix :api
  format :json
  content_type :json, 'application/json;charset=UTF-8'

  helpers do

    def authenticate_user!
      begin
        payload, _= JWT.decode(params[:access_token], 'key')
        @current_user = User.find_by(username: payload['username'])
        error!({error: '用户不存在'},401 ) if @current_user.nil?
      rescue StandardError=>e
        error!({error: e.message},401 )
      end
    end

    def current_user
       @current_user
    end

  end
  mount PostsAPI
  mount SessionAPI
  mount UsersAPI
end