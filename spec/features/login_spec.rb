require 'rails_helper'

RSpec.describe 'login', type: :feature do
  before(:each) do
    @user = User.create!(name: 'test', photo:'https://images.unsplash.com/photo-1508921912186-1d1a45ebb3c1?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80', email: 'test@mail.com', password: '123456')
    @user.confirmed_at = Time.now
  end

  it "can see the email and password inputs and the 'Sign In' button" do
    visit ('/users/sign_in')
    login_as(@user, :scope => :user)
    click_button('Log in')
    expect(page).to have_content('test')
  end

  it 'button click throws error when no username and password are entered' do
    visit('/users/sign_in')
    click_button('Log in')
    expect(page).to have_content('Invalid Email or password.')
  end

  it 'When I click the submit button after filling in the username and the password with incorrect data, I get a detailed error.' do
    visit('/users/sign_in')
    fill_in 'Email', with: ''
    fill_in 'Password', with: ''
    click_button('Log in')
    expect(page).to have_current_path('/users/sign_in')
  end

  it 'When I click the submit button after filling in the username and the password with correct data, I am redirected to the root page' do
    root = root_path
    visit('/users/sign_in')
    login_as(@user, :scope => :user)
    click_button('Log in')
    expect(page).to have_current_path(root)
  end
end