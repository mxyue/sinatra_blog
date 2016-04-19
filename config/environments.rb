
environment = ENV['RACK_ENV'] || 'development'
db_options = YAML.load(File.read('./config/database.yml'))
ActiveRecord::Base.establish_connection db_options[environment]