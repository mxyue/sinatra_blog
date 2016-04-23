module Entities
    class Post < Grape::Entity
        root 'posts'
        expose :id, documentation: {type: Integer, desc: '帖子id'}
        expose :content, documentation: {type: String, desc: '帖子内容'}
        expose :pictures_url, as: :pictures, documentation: {type: Array, desc: '帖子图片'} 
        expose :username, documentation: {type: String, desc: '用户名'} do |post|
            post.user.try(:username)
        end
        expose :created_at do |post|
            post.created_at.to_i
        end

        # expose :total_pages
    end
end