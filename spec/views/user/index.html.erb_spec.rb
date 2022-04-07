require 'rails_helper'

RSpec.describe 'user index page', type: :feature do
  before(:each) do
    @user = User.create!(name: 'User Name', photo:'https://images.unsplash.com/photo-1508921912186-1d1a45ebb3c1?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80', email: 'test@mail.com', password: '123456')
    @user.confirmed_at = Time.now

    @second_user = User.create!(name: 'Second User', photo:'https://images.unsplash.com/photo-1508921912186-1d1a45ebb3c1?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80', email: 'test2@mail.com', password: '123456')
    @second_user.confirmed_at = Time.now

    login_as(@user, :scope => :user)
  end

  it "can see the username of all other users." do
    visit('/users')
    expect(page).to have_content('User Name')
    expect(page).to have_content('Second User')
  end

  it "can see the profile picture for each user." do
    visit('/users')
    expect(all('img').count).to eq(2)
  end

  it "can see the number of posts each user has written." do
    visit('/users')
    expect(all('.post-counter').count).to eq(2)
  end

  it "click on a user and redirected to that user's show page" do
    visit('/users')
    click_on 'Second User'
    expect(page).to have_current_path(user_path(@second_user))
  end
end