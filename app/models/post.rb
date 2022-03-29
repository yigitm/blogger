class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many :comments, foreign_key: 'post_id', dependent: :destroy
  after_save :post_counter

  def self.post_counter(user)
    user.increment!(:posts_counter)
  end

  def self.recent_comments(post)
    Comment.where('post_id = ?', post.id).order(id: :desc).limit(5)
  end
end
