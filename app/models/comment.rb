class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  belongs_to :post, class_name: 'Post', foreign_key: 'post_id'

  def self.comment_counter(post)
    value = post.comments_counter += 1
    post.update(comments_counter: value)
  end
end
