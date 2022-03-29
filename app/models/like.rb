class Like < ApplicationRecord
  belongs_to :author, foreign_key: 'author_id'
  belongs_to :post, foreign_key: 'post_id'
  after_save :like_counter

  def self.like_counter(post)
    post.increment!(:likes_counter)
  end
end
