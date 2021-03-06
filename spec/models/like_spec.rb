require 'rails_helper'

RSpec.describe Like, type: :model do
  user = User.create(name: 'Test User',
                     photo: 'https//photo.com/photo', bio: 'lorem ipsum', posts_counter: 23)
  post = Post.create(author_id: user.id, title: 'Test', text: 'Lorem Ipsum', comments_counter: 0, likes_counter: 0)
  subject { Like.new(author_id: user.id, post_id: post.id) }

  before { subject.save }

  it 'likes counter in post should be 2' do
    expect(subject.post.likes_counter).to eq(1)
  end

  it 'like should be valid' do
    expect(subject).to be_valid
  end
end
