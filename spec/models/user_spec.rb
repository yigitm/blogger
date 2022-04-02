require 'rails_helper'

RSpec.describe User, type: :model do
  subject do
    User.new(name: 'Test User',
             photo: 'https//photo.com/photo', bio: 'lorem ipsum', posts_counter: 23)
  end

  before { subject.save }

  it 'name should be present' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'posts counter should be integer' do
    subject.posts_counter = 'String'
    expect(subject).to_not be_valid
  end

  it 'posts counter should be >= 0' do
    subject.posts_counter = -23
    expect(subject).to_not be_valid
  end

  it 'subject should be valid' do
    expect(subject).to be_valid
  end
end
