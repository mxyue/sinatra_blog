class PostsAPI < Grape::API

  params do
    requires :access_token, type: String, desc: '用户的access_token'
  end

  before do
    authenticate_user!
  end

  resource :posts do
    desc '获取帖子列表'
    get do
      present ::Post.all.includes(:user).order(created_at: :desc), with: Entities::Post
    end

    desc '创建帖子'
    params do
        optional :content, type: String
        optional :pictures
        at_least_one_of :content, :pictures
    end
    post do
      pictures = []
      if params[:pictures].present?
        (params[:pictures]||[]).each do |pic|
          filename = pic[:filename]
          file = pic[:tempfile]

          File.open("/Users/mxyue/study/sinatra/sinatra_blog/public/resources/user_avatars/#{filename}", 'wb') do |f|
            f.write(file.read)
          end
          pictures << filename.to_s
        end
      end  
    

      post = Post.new(content: params[:content], pictures: pictures, user: current_user)
      if post.save
          status 200
          {success: true}
      else
          status 400
          {error: '标题长度不够'}
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