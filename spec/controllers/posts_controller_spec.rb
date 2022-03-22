require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  context 'GET #index' do
    before(:example) { get user_posts_path(1) }
    it 'is a success' do
      expect(response).to have_http_status(:ok)
    end

    it "renders 'user posts' template" do
      expect(response).to render_template('index')
    end
  end

  context 'GET #show' do
    before(:example) { get user_post_path(1, 1) }
    it 'is a success' do
      expect(response).to have_http_status(:ok)
    end

    it "renders 'show' template" do
      expect(response).to render_template('show')
    end
  end
end

RSpec.describe 'Posts', type: :feature do
  context 'the posts pages' do
    it 'should includes the correct placeholder text' do
      visit 'users/1/posts'
      expect(page).to have_text('List of User Posts - action: posts#index')
    end

    it 'should includes the correct placeholder text' do
      visit 'users/1/posts/1'
      expect(page).to have_text('User Single Post Page - action: posts#show')
    end
  end
end
