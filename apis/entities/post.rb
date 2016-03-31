module Entities
    class Post < Grape::Entity
        expose :title, documentation: {type: String, desc: '帖子标题'}
        expose :body, documentation: {type: String, desc: '帖子内容'}
        expose :created_at
    end
end