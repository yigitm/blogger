require 'rails_helper'

RSpec.describe 'post show page', type: :feature do
  before(:each) do
    # rubocop:disable Layout/LineLength
    @user = User.create!(name: 'User Name',
                         photo: 'https://images.unsplash.com/photo-1508921912186-1d1a45ebb3c1?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80', email: 'test@mail.com', password: '123456')
    # rubocop:enable Layout/LineLength
    @user.confirmed_at = Time.now

    login_as(@user, scope: :user)

    @post = Post.create!(author_id: @user.id, title: 'Post title', text: 'Post text.')
  end

  it "can see a post's title" do
    visit user_post_path(@user, @post)
    expect(page).to have_content('Post title')
  end

  it 'can see who wrote the post' do
    visit user_post_path(@user, @post)
    expect(page).to have_selector('.post-title', text: 'Post title by User Name')
  end

  it 'can see how many comments it has' do
    @comment = Comment.create!(author_id: @user.id, post_id: @post.id, text: 'Comment text')

    visit user_post_path(@user, @post)
    expect(page).to have_selector('.post-c-counter', text: 'Comments: 1')
  end

  it 'can see how many likes it has' do
    @like = Like.create!(author_id: @user.id, post_id: @post.id)

    visit user_post_path(@user, @post)
    expect(page).to have_selector('.post-l-counter', text: 'Likes: 1')
  end

  it 'can see the post body' do
    visit user_post_path(@user, @post)
    expect(page).to have_content('Post text.')
  end

  it 'can see the username of each commentor' do
    @comment = Comment.create!(author_id: @user.id, post_id: @post.id, text: 'Comment text')

    visit user_post_path(@user, @post)
    expect(page).to have_selector('p', text: "Username: #{@user.name}")
  end

  it 'can see the comment each commentor left' do
    @comment = Comment.create!(author_id: @user.id, post_id: @post.id, text: 'Comment text')

    visit user_post_path(@user, @post)
    expect(page).to have_selector('p', text: "Comment: #{@comment.text}")
  end
end
