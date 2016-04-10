class UsersAPI < Grape::API
  params do
    requires :access_token, type: String, desc: '用户的access_token'
  end

  before do
    authenticate_user!
  end

  resource :users do
    get do
      present current_user, with: Entities::User
    end

    params do
      requires :avatar, desc: '用户头像'
    end
    post :avatar do
      filename = params[:avatar][:filename]
      file = params[:avatar][:tempfile]

      File.open("/Users/mxyue/study/resources/user_avatars/#{filename}", 'wb') do |f|
        f.write(file.read)
      end
      current_user.update(avatar: filename)
      {success: 'true'}
    end
  end
end