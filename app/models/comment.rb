class Comment < ActiveRecord::Base
  validates :body, :comments_id, :comments_type, presence: :true
  
  belongs_to :comments, polymorphic: true
end
