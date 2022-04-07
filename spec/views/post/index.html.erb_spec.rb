require 'rails_helper'

RSpec.describe 'user post index page', type: :feature do
  # rubocop:disable Layout/LineLength
  before(:each) do
    @user = User.create!(name: 'User Name',
                         photo: 'https://images.unsplash.com/photo-1508921912186-1d1a45ebb3c1?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80', email: 'test@mail.com', password: '123456')

    @user.confirmed_at = Time.now

    @seconduser = User.create!(name: 'Second User',
                               photo: 'https://images.unsplash.com/photo-1508921912186-1d1a45ebb3c1?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80', email: 'test2@mail.com', password: '123456')
    # rubocop:enable Layout/LineLength
    @seconduser.confirmed_at = Time.now
    login_as(@user, scope: :user)

    @post = Post.create!(author_id: @user.id, title: 'Post title', text: 'Post text.')
  end

  it "can see the user's profile picture" do
    visit user_posts_path(@user)
    expect(all('img').count).to eq(1)
  end

  it "can see the user's username" do
    visit user_posts_path(@user)
    expect(page).to have_content('User Name')
  end

  it 'can see the number of posts the user has written' do
    visit user_posts_path(@user)
    expect(all('.post-counter').count).to eq(1)
  end

  it "can see a post's title" do
    visit user_posts_path(@user)
    expect(page).to have_content('Post title')
  end

  it "can see a post's title" do
    visit user_posts_path(@user)
    expect(page).to have_content('Post text.')
  end

  it "can see some of the post's body" do
    @post1 = Post.create!(author_id: @user.id, title: 'Post 1', text: 'Post text 1')
    @post2 = Post.create!(author_id: @user.id, title: 'Post 2', text: 'Post text 2')
    @post3 = Post.create!(author_id: @user.id, title: 'Post 3', text: 'Post text 3')

    visit user_posts_path(@user)
    expect(page).to have_content('Post text 1')
    expect(page).to have_content('Post text 2')
    expect(page).to have_content('Post text 3')
  end

  it 'can see the first comments on a post' do
    @comment = Comment.create!(author_id: @user.id, post_id: @post.id, text: 'Comment text')

    visit user_posts_path(@user)
    expect(page).to have_content('Comment text')
  end

  it 'can see how many comments a post has' do
    @comment = Comment.create!(author_id: @user.id, post_id: @post.id, text: 'Comment text')

    visit user_posts_path(@user)
    expect(page).to have_selector('.post-c-counter', text: 'Comments: 1')
  end

  it 'can see how many likes a post has' do
    visit user_posts_path(@user)
    expect(page).to have_content('Likes')
  end

  it 'can see a section for pagination if there are more posts than fit on the view' do
    visit user_posts_path(@user)
    expect(page).to have_button('pagination')
  end

  it "click on a post, it redirects to that post's show page" do
    visit user_posts_path(@user)
    click_on 'Post title'
    expect(page).to have_current_path(user_post_path(@user, @post))
  end
end
