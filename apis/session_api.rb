class SessionAPI < Grape::API
  resource :session do
    params do
      requires :username, type: String
      requires :password, type: String
    end
    post do
      
      user = User.find_by(username: params[:username])
      if user && user.password == params[:password]
        status 200
        access_token = JWT.encode({username: user.username, exp: 7.day.from_now.to_i}, 'key')
        {access_token: access_token}
      else
        status 401
        {error: '密码错误或则用户不存在'}
      end
    end
  end
end