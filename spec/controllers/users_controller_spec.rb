require 'rails_helper'

RSpec.describe 'Users', type: :request do
 describe 'GET #index' do
   before(:example) { get users_path }  # get(:index)
   it "is a success" do
     expect(response).to have_http_status(:ok)
   end
   
   it "renders 'index' template" do
     expect(response).to render_template('index')
   end
 end
end

RSpec.describe 'Users', type: :feature do
  describe 'the users page' do
    it 'should includes the correct placeholder text' do
      visit 'users'
      expect(page).to have_text('List of Users - Root Page - action: users#index')
    end
  end
end