# require 'mongo'



configure :development do
    ActiveRecord::Base.establish_connection(
        :adapter => 'sqlite3',
        :database =>  'sinatra_application.sqlite3.db'
    )
    # db = Mongo::Client.new([ '127.0.0.1:27017' ], :database => 'development_blog')  
    # set :mongo_db, db[:development_blog]
end

# configure :production do
#  db = URI.parse(ENV['DATABASE_URL'] || 'postgres:///localhost/mydb')

#  ActiveRecord::Base.establish_connection(
#    :adapter  => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
#    :host     => db.host,
#    :username => db.user,
#    :password => db.password,
#    :database => db.path[1..-1],
#    :encoding => 'utf8'
#  )
# end