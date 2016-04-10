require 'paperclip'
class User < ActiveRecord::Base
  # include Paperclip::Glue
  has_many :posts

  # has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  # validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
  #
  # attr_accessor :upload
  #
  # def self.save_file(upload)
  #
  #   file_name = upload['datafile'].original_filename  if  (upload['datafile'] !='')
  #   file = upload['datafile'].read
  #
  #   file_type = file_name.split('.').last
  #   new_name_file = Time.now.to_i
  #   name_folder = new_name_file
  #   new_file_name_with_type = "#{new_name_file}." + file_type
  #
  #   image_root = "#{RAILS_CAR_IMAGES}"
  #
  #
  #   Dir.mkdir(image_root + "#{name_folder}");
  #     File.open(image_root + "#{name_folder}/" + new_file_name_with_type, "wb")  do |f|
  #       f.write(file)
  #     end
  #
  # end
end