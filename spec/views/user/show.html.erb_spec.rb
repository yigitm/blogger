require 'rails_helper'

RSpec.describe 'user show page', type: :feature do
  before(:each) do
    # rubocop:disable Layout/LineLength
    @user = User.create!(name: 'User Name', bio: 'User bio. text',
                         photo: 'https://images.unsplash.com/photo-1508921912186-1d1a45ebb3c1?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80', email: 'test@mail.com', password: '123456')
    # rubocop:enable Layout/LineLength
    @user.confirmed_at = Time.now
    login_as(@user, scope: :user)
  end

  it 'can see the profile picture for each user.' do
    visit user_path(@user)
    expect(all('img').count).to eq(1)
  end

  it "can see the user's username" do
    visit user_path(@user)
    expect(page).to have_content('User Name')
  end

  it 'can see the number of posts the user has written.' do
    visit user_path(@user)
    expect(page).to have_selector('h3', text: 'Number of posts:0')
  end

  it "can see the user's bio" do
    visit user_path(@user)
    expect(page).to have_selector('p', text: 'User bio. text')
  end

  it "can see the user's first 3 posts" do
    @post1 = Post.create!(author_id: @user.id, title: 'Post 1', text: 'Post text.')
    @post2 = Post.create!(author_id: @user.id, title: 'Post 2', text: 'Post text.')
    @post3 = Post.create!(author_id: @user.id, title: 'Post 3', text: 'Post text.')
    visit user_path(@user)
    expect(all('p', text: 'Post text.').count).to eq(3)
  end

  it "can see a button that lets to view all of a user's posts" do
    visit user_path(@user)
    expect(page).to have_button('See all posts')
  end

  it "click a user's post, it redirects to that post's show page" do
    @post = Post.create!(author_id: @user.id, title: 'Post', text: 'Post text.')
    visit user_path(@user)
    click_on 'Post'
    expect(page).to have_current_path(user_posts_path(@user))
  end

  it "click to see all posts, it redirects to the user's post's index page" do
    visit user_path(@user)
    click_button 'See all posts'
    expect(page).to have_current_path(user_posts_path(@user))
  end
end
