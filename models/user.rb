class User < ActiveRecord::Base
  # include Paperclip::Glue
  has_many :posts

  def last_dynamic_at
    self.posts.order(created_at: :desc).first.try(:created_at).to_i || 0
  end
end