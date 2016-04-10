module SharedParams
  extend Grape::API::Helpers
  params :user_session do
    requires :access_token, type: String, desc: '用户的access_token', documentation: { param_type: 'query' }
  end
end