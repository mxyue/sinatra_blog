require File.expand_path '../../spec_helper.rb', __FILE__

RSpec.describe API do
  include Rack::Test::Methods

  def app
    API.new
  end

  describe 'Grape 测试'  do
    let(:user){User.create(username: 'test', password: '123456')}
    let(:access_token){ JWT.encode({username: user.username, exp: 7.day.from_now.to_i}, 'key')}
    let(:post1){ user.posts.create(content: 'post1-content')}
    let(:create_posts){ 25.times{|i| Post.create(content: "content-#{i}")}}
    let(:post2){ user.posts.create(content: 'post2-content')}
    it '应该成功获取帖子' do
      post1
      create_posts
      response = get '/api/posts',access_token: access_token, last_dynamic_at: post2.created_at.to_i, per_page: 20
      expect(response.status).to eq 200
      body = JSON.parse(response.body)
      posts = body['posts']
      expect(posts.count).to eq 20
      expect(body['last_dynamic_at']).to eq post2.created_at.to_i

      response = get '/api/posts',access_token: access_token, page: 2, per_page: 20
      expect(response.status).to eq 200
      posts = JSON.parse(response.body)['posts']
      expect(posts.count).to eq 7
      expect(posts.last['content']).to eq post1.content

      response = get '/api/posts',access_token: access_token, last_dynamic_at: post1.created_at.to_i-1
      expect(response.status).to eq 203
      message = JSON.parse(response.body)['message']
      expect(message).to eq ''

    end

  end
end


