class PostsAPI < Grape::API
  resource :posts do
    desc '获取帖子列表'
    get do
      present ::Post.all, with: Entities::Post
    end

    
    params do
        requires :id
    end
    route_param :id do
        desc '获取帖子详情' 
        get do
            present Post.find(params[:id]), with: Entities::Post
        end
    end
  end
end