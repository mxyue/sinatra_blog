
# configure :development do
#     ActiveRecord::Base.establish_connection(
#         :adapter => 'sqlite3',
#         :database =>  'sinatra_application.sqlite3.db'
#     )
#     # db = Mongo::Client.new([ '127.0.0.1:27017' ], :database => 'development_blog')  
#     # set :mongo_db, db[:development_blog]
# end

db_options = YAML.load(File.read('./config/database.yml'))
ActiveRecord::Base.establish_connection(db_options)