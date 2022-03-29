class User < ApplicationRecord
  has_many :comments, foreign_key: :author_id, dependent: :destroy
  has_many :posts, foreign_key: :author_id, dependent: :destroy
  has_many :likes, foreign_key: :author_id, dependent: :destroy

  def self.recent_posts(user)
    Post.where('author_id = ?', user.id).order(id: :desc).limit(3)
  end
end
