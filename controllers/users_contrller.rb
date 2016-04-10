get '/user/info' do
  check_authentication
  erb :'users/info'
end

post '/user/info' do
  logger.info params
  check_authentication

  @filename = params[:file][:filename]
  file = params[:file][:tempfile]

  File.open("/Users/mxyue/study/resources/user_avatars/#{@filename}", 'wb') do |f|
    f.write(file.read)
  end

  erb :'/users/show_image'

  # current_user.update(avatar: params[:avatar])
  # redirect :'/user/info'
end
