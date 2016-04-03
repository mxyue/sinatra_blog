class PostsAPI < Grape::API
  resource :posts do
    desc '获取帖子列表'
    get do
      present ::Post.all.order(created_at: :desc), with: Entities::Post
    end

    desc '创建帖子'
    params do
        requires :title, type: String
        requires :body, type: String
    end
    post do
        
        post = Post.new(title: params[:title], body: params[:body])
        if post.save 
            status 200
            {success: true}
        else
            {success: false, error: '标题长度不够'}
        end

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