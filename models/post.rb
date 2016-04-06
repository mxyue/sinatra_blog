class Post < ActiveRecord::Base
    validates :content, presence: true, length: { minimum: 3 }
    serialize :pictures
    belongs_to :user

    # has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
    # validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

end 