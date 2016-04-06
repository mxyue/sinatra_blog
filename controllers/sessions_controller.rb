get "/login" do
  erb 'sessions/login'.to_sym
end

post "/session" do
  warden_handler.authenticate!
  if warden_handler.authenticated?
    redirect "/posts/new"
  else
    redirect "/"
  end
end

get "/logout" do
  warden_handler.logout
  redirect '/login'
end

post "/unauthenticated" do
  redirect "/"
end