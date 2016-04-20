class PostsAPI < Grape::API

  helpers do
    def logger
      API.logger
    end
  end

  params do
    requires :access_token, type: String, desc: '用户的access_token'
  end

  before do
    authenticate_user!
  end

  resource :posts do
    params do
      optional :page, default: 1
      optional :per_page, default: 20
    end
    desc '获取帖子列表'
    get do
      present ::Post.paginate(page: params[:page],per_page: params[:per_page]).includes(:user).
                  order(created_at: :desc), with: Entities::Post
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
          logger.info pic[:filename]
          filename = pic[:filename]
          file = pic[:tempfile]

          File.open("public/resources/post_pictures/#{filename}", 'wb') do |f|
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