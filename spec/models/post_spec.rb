require 'rails_helper'

RSpec.describe Post, type: :model do
  user = User.create(name: 'Test User',
                     photo: 'https//photo.com/photo', bio: 'lorem ipsum', posts_counter: 23)
  subject { Post.new(author_id: user.id, title: 'Test', text: 'Lorem Ipsum', comments_counter: 0, likes_counter: 0) }

  before { subject.save }

  it 'title should be present' do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  it 'title length should be <= 255' do
    subject.title = 'a' * 256
    expect(subject).to_not be_valid
  end

  it 'comments counter should be integer' do
    subject.comments_counter = 'string'
    expect(subject).to_not be_valid
  end

  it 'comments counter should be >= 0' do
    subject.comments_counter = -3
    expect(subject).to_not be_valid
  end

  it 'likes counter should be integer' do
    subject.likes_counter = 'string'
    expect(subject).to_not be_valid
  end

  it 'likes counter should be >= 0' do
    subject.likes_counter = -3
    expect(subject).to_not be_valid
  end

  it 'subject should be valid' do
    expect(subject).to be_valid
  end
end
