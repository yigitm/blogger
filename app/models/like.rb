class Like < ApplicationRecord
  belongs_to :author, foreign_key: 'author_id'
  belongs_to :post, foreign_key: 'post_id'

  def self.like_counter(post)
    value = post.likes_counter += 1
    post.update(likes_counter: value)
  end
end
