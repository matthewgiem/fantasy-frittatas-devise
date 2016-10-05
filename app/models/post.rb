class Post < ActiveRecord::Base
  validates_presence_of :text
  belongs_to :user
  has_many :comments
end
