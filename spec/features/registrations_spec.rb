require 'rails_helper'

RSpec.feature "Registrations", type: :feature do
  describe "the signin process", :type => :feature do

    it "signs me in" do
      visit '/signup'
      within("#signup_form") do
        fill_in 'user[name]', with: 'test user'
        fill_in 'user[email]', with: 'testuser@example.com'
        fill_in 'user[password]', with: 'password123'
        fill_in 'user[password_confirmation]', with: 'password123'
      end
      click_button 'Create Account'
      expect(page).to have_content 'Welcome!'
    end
  end
end
