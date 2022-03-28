class User < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy

  def self.recent_users(user)
    Post.where('author_id = ?', user.id).order(id: :desc).limit(3)
  end
end
