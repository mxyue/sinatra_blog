require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/flash'
require 'sinatra/redirect_with_flash'
require './environments'
Dir.glob("controllers/*.rb").each { |r| require_relative r }
Dir.glob("models/*.rb").each { |r| require_relative r }

enable :sessions

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
