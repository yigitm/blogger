require 'rails_helper'

RSpec.describe 'Users', type: :request do
  context 'GET #index' do
   before(:example) { get users_path }
   it "is a success" do
     expect(response).to have_http_status(:ok)
   end
   
   it "renders 'index' template" do
     expect(response).to render_template('index')
   end
  end
  context 'GET #show' do
   before(:example) { get user_path(1) }
   it "is a success" do
     expect(response).to have_http_status(:ok)
   end
   
   it "renders 'show' template" do
     expect(response).to render_template('show')
   end
  end
end

RSpec.describe 'Users', type: :feature do
  context 'the users #index/#show pages' do
    it 'should includes the correct placeholder text' do
      visit 'users'
      expect(page).to have_text('List of Users - Root Page - action: users#index')
    end
  
    it 'should includes the correct placeholder text' do
      visit 'users/1'
      expect(page).to have_text('Single User Page - action: users#show')
    end
  end
end