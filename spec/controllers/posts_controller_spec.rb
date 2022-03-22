require 'rails_helper'

RSpec.describe 'Posts', type: :request do
 context 'GET #index' do
   before(:example) { get posts_path }
   it "is a success" do
     expect(response).to have_http_status(:ok)
   end
   
   it "renders 'index' template" do
     expect(response).to render_template('index')
   end
  end
end

RSpec.describe 'Posts', type: :feature do
  context 'the posts page' do
    it 'should includes the correct placeholder text' do
      visit 'posts'
      expect(page).to have_text('List of posts - Root Page - action: posts#index')
    end
  end
end