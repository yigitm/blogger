class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many :comments, foreign_key: 'post_id', dependent: :destroy

  after_initialize :init

  after_save :update_post_counter

  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def init
    self.comments_counter ||= 0 # will set the default value only if it's nil
    self.likes_counter ||= 0 # will set the default value only if it's nil
  end

  def update_post_counter
    author.increment!(:posts_counter)
  end

  def self.recent_comments(post)
    post.comments.order(id: :desc).limit(5).eager_load(:author)
  end
end
