require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: 'Test User', photo:'https://images.unsplash.com/photo-1508921912186-1d1a45ebb3c1?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80', bio: 'lorem ipsum', posts_counter: 23 ) }

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

  it 'name should be present' do
    expect(subject).to be_valid
  end

  it 'posts counter should be integer' do
    expect(subject).to be_valid
  end

  it 'posts counter should be >= 0' do
    expect(subject).to be_valid
  end
end
