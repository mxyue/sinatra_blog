require File.expand_path '../../spec_helper.rb', __FILE__

RSpec.describe API do
  include Rack::Test::Methods

  def app
    API.new
  end

  describe 'Grape 测试'  do
    let(:user){User.create(username: 'test', password: '123456')}
    let(:access_token){ JWT.encode({username: user.username, exp: 7.day.from_now.to_i}, 'key')}
    let(:post1){ Post.create(content: 'post1-content')}
    let(:post2){ Post.create(content: 'post2-content')}
    let(:create_posts){ 25.times{|i| Post.create(content: "content-#{i}")}}
    it '应该成功获取帖子' do
      post1
      create_posts
      response = get '/api/posts',access_token: access_token
      expect(response.status).to eq 200
      posts = JSON.parse(response.body)['posts']
      expect(posts.count).to eq 20

      response = get '/api/posts',access_token: access_token, page: 2
      expect(response.status).to eq 200
      posts = JSON.parse(response.body)['posts']
      expect(posts.count).to eq 6
      expect(posts.last['content']).to eq post1.content
    end

  end
end


