class Photo < ActiveRecord::Base
  belongs_to :imageable, polymorphic: true
    belongs_to :user
    belongs_to :profile

  attr_accessible :image
    has_attached_file :image, :styles => { :medium => "200x200#", :thumb => "25x25#" }, :default_url => "/images/default/:style/default_user.jpg",
    :url  => "/images/:id/:style/:basename.:extension",
    :path => ":rails_root/public/images/:id/:style/:basename.:extension"
    
end