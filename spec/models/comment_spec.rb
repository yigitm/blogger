require 'rails_helper'

RSpec.describe Comment, type: :model do
  user = User.create(name: 'Test User', photo:'https://images.unsplash.com/photo-1508921912186-1d1a45ebb3c1?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80', bio: 'lorem ipsum', posts_counter: 23 ) 
  post = Post.create(author_id: user.id, title: 'Test', text: 'Lorem Ipsum', comments_counter: 1, likes_counter: 0)
  subject { Comment.new(text: 'Comment', author_id: user.id, post_id: post.id) }

  before { subject.save }

  it 'text should be present' do
    subject.text = nil
    expect(subject).to_not be_valid
  end

  it 'comment should be valid' do
    expect(subject).to be_valid
  end

  it 'comments counter in post should be 1' do
    expect(subject.post.comments_counter).to eq(2)
  end
end
