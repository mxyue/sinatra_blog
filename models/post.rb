class Post < ActiveRecord::Base
    serialize :pictures
    belongs_to :user

    # has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
    # validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

    def pictures_url
        pictures.map{|picture| 'http://192.168.31.100/resources/user_avatars/'+picture } if pictures.present?
    end
end 