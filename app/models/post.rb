class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many :comments, dependent: :destroy

  def self.update_post_counter(user)
    value = user.posts_counter += 1
    user.update(posts_counter: value)
  end

  def self.recent_comments(post)
    Comment.where('post_id = ?', post.id).order(id: :desc).limit(5)
  end
end
