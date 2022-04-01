class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many :comments, foreign_key: 'post_id', dependent: :destroy
  after_save :update_post_counter
  after_initialize :init

  validates :title, presence: true, length: { in: 1..250 }

  def init
    self.comments_counter ||= 0 # will set the default value only if it's nil
    self.likes_counter ||= 0 # will set the default value only if it's nil
  end

  def update_post_counter
    author.increment!(:posts_counter)
  end

  def self.recent_comments(post_id)
    Comment.where('post_id = ?', post_id).order(id: :desc).limit(5)
  end
end
