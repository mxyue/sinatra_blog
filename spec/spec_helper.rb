ENV['RACK_ENV'] = 'test'
require 'grape'
require 'grape-entity'
require 'database_cleaner'
require 'rack/test'

require File.expand_path('../../apis/api.rb', __FILE__)
require File.expand_path('../../app.rb', __FILE__)


RSpec.configure do |config|

  DatabaseCleaner.strategy = :transaction
  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end


  config.after(:each) do
    DatabaseCleaner.clean_with(:truncation)
  end


end
