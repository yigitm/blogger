require 'rails_helper'

RSpec.describe 'index page', type: :feature do
  #pending "add some examples to (or delete) #{__FILE__}"
  scenario 'index page' do
    visit users_path
    expect(page).to have_content('Go to Profile =>')
  end
end