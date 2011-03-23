class Profile < ActiveRecord::Base
  belongs_to :user
  
  has_attached_file :image, :styles => {
        :thumb=> "40x40>",
        :small  => "60x60>",
        :medium => "80x80>",
        :large => '128x128>' },
        :url => "/system/:class/:attachment/:id/:style/:basename.:extension",
        :path => ":rails_root/public/system/:class/:attachment/:id/:style/:basename.:extension"
        
end
