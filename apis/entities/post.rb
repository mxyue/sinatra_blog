module Entities
    class Post < Grape::Entity
        root 'posts'
        expose :id, documentation: {type: Integer, desc: '帖子id'}
        expose :content, documentation: {type: String, desc: '帖子内容'}
        expose :pictures, documentation: {type: Array, desc: '帖子图片'}
        expose :created_at do |post|
            post.created_at.strftime('%Y-%m-%d %H:%M:%S')
        end
    end
end