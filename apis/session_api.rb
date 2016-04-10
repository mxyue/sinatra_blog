class SessionAPI < Grape::API
  resource :session do
    params do
      requires :username, type: String
      requires :password, type: String
    end
    post do
      status 200
      user = User.find_by(username: params[:username])
      if user.password == params[:password]
        access_token = JWT.encode({username: user.username, exp: 1.day.from_now.to_i}, 'key')
        {access_token: access_token}
      end
    end
  end
end