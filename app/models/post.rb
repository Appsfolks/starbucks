class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments, :dependent=>:destroy
  
  acts_as_commentable
  
  validates :post_content, :presence=>true
  validates :user_id, :presence=>true
end
