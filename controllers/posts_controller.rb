get "/" do
  @posts = Post.order("created_at DESC")
  @title = "post."
  erb :"posts/index"
end

get "/posts/new" do
 @title = "Create post"
 @post = Post.new
 erb :"posts/new"
end

get "/posts/:id" do
 @post = Post.find(params[:id])
 @title = @post.title
 erb :"posts/show"
end

post "/posts" do
 @post = Post.new(params[:post])
 if @post.save
   redirect "posts/#{@post.id}"
 else
   erb :"posts/new"
 end
end