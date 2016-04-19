require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/flash'
require 'sinatra/redirect_with_flash'
require './config/environments'
require 'warden'

Dir.glob('controllers/*.rb').each { |r| require_relative r }
Dir.glob('models/*.rb').each { |r| require_relative r }

use Rack::Session::Cookie, :secret => "dsfsdfsdfsfsd"


use Warden::Manager do |manager|
  manager.default_strategies :password
  manager.failure_app = Sinatra::Application
  manager.serialize_into_session {|user| user.id}
  manager.serialize_from_session {|id| User.find_by_id(id)}
end

Warden::Manager.before_failure do |env,opts|
  env['REQUEST_METHOD'] = 'POST'
end

Warden::Strategies.add(:password) do
  def valid?
    params["username"] || params["password"]
  end

  def authenticate!
    user = User.find_by_username(params["username"])
    if user && user.password == params["password"]
      success!(user)
    else
      fail!("Could not log in")
    end
  end
end

def warden_handler
  env['warden']
end

def check_authentication
    redirect '/login' unless warden_handler.authenticated?
end

def current_user
    warden_handler.user
end







helpers do
  def title
    if @title
      "#{@title}"
    else
      "Welcome."
    end
  end
end

after do
  ActiveRecord::Base.connection.close
end
