class Movie < ActiveRecord::Base
	belongs_to :user
	has_many :reviews

	has_attached_file :avatar, styles: { :original => "250x250#", :thumb => "100x100#", :speck => "25x25#" }, default_url: "/images/:style/missing.png"
  	validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

end
