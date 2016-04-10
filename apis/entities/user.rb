module Entities
    class User < Grape::Entity
        expose :id, documentation: {type: Integer, desc: '用户id'}
        expose :username, documentation: {type: String, desc: '用户名'}
        expose :avatar, documentation: {type: String, desc: '头像'}
        expose :created_at do |post|
            post.created_at.strftime('%Y-%m-%d %H:%M:%S')
        end
    end
end