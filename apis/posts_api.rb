class PostsAPI < Grape::API
  resource :posts do
    desc '获取帖子列表'
    get do
      present ::Post.all, with: Entities::Post
    end
  end
end