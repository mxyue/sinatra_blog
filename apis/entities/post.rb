module Entities
    class Post < Grape::Entity
        root 'posts'
        expose :id, documentation: {type: Integer, desc: '帖子id'}
        expose :title, documentation: {type: String, desc: '帖子标题'}
        expose :body, documentation: {type: String, desc: '帖子内容'}
        expose :created_at do |post|
            post.created_at.strftime('%Y-%m-%d %H:%M:%S')
        end
    end
end