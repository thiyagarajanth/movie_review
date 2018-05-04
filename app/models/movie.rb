class Movie < ActiveRecord::Base
	belongs_to :user
	has_many :reviews

	has_attached_file :avatar, styles: { :original => "250x250#", :thumb => "100x100#", :speck => "25x25#" }, default_url: "/images/:style/missing.png"
  	validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  	acts_as_votable
  	acts_as_ratee


  	def set_avg_rating
  		ratings = self.reviews.map(&:rating)
  		nan = (ratings.inject{ |sum, el| sum + el }.to_f / ratings.size).round(2) 
  		(nan.is_a?(Float) && nan.nan?) ? 0 : nan
  	end
end
