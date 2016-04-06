
get '/' do
  @posts = Post.order("created_at DESC")
  erb :'posts/index'
end

get '/posts/new' do
    check_authentication
     @post = Post.new(user: current_user)
     erb :'posts/new'
end

# get "/posts/:id" do
#  @post = Post.find(params[:id])
#  @title = @post.title
#  erb :"posts/show"
# end

post '/posts' do
 logger.info params
 check_authentication
 @post = Post.new(post_params)
 if @post.save
   redirect '/'
 else
   erb :'posts/new'
 end
end

private
def post_params
  params[:post].except(:id).merge(user_id: current_user.id)
end