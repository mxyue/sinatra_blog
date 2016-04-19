require File.expand_path '../../spec_helper.rb', __FILE__

RSpec.describe API do

  describe 'Grape 测试'  do
    let(:user){User.create(username: 'test', password: '123456')}
    let(:access_token){ JWT.encode({username: user.username, exp: 7.day.from_now.to_i}, 'key')}
    let(:post1){ Post.create(content: 'post1-content')}
    let(:post2){ Post.create(content: 'post2-content')}
    it '应该成功获取帖子' do
      post1
      response = get '/api/posts',parameters: {access_token: access_token}
      expect(response.code).to eq 200
      posts = response.body['posts']
      expect(posts.count).to eq 1
      expect(posts.first['content']).to eq post1.content

    end

  end
end


