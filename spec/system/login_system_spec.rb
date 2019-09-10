require 'rails_helper'

describe 'Authentication' do
  context 'when no player is logged in' do
    it 'provides a way for players to sign up' do
      # When I visit the root page
      visit '/'
      
      # The navbar should provide buttons for sign up and sign in
      within("#navbar") do
        expect(page).to have_link 'Sign up'
        expect(page).to have_link 'Sign in'
        
        # When I click sign in
        click_on 'Sign in'
      end
      
      within("#main_container") do
        # I should see the Sign in page
        expect(page).to have_text 'Sign in'
        
        # The sign in page has a link to the Sign up page
        expect(page).to have_text 'Sign up'
        
        # When I click on the sign up link
        click_on 'Sign up'
      end
      
      within("#main_container") do
        # I should see the Sign up page
        expect(page).to have_text 'Sign up'
        # When I complete the form and submit
        fill_in 'Email', with: 'fake@example.com'
        fill_in 'Password', with: 'Password1'
        fill_in 'Password confirmation', with: 'Password1'
        click_on 'Sign up'
      end
      
      # I should be logged in
      expect(page).to have_text 'Welcome! You have signed up successfully'

      # When I visit /logout
      click_on 'Sign out'

      # I should be logged out
      expect(page).to have_text 'Signed out successfully'

      # When I visit /login
      click_on 'Sign in'

      # I should be able to log in.
      within("#main_container") do
        fill_in 'Email', with: 'fake@example.com'
        fill_in 'Password', with: 'Password1'
        click_on 'Sign in'
      end
  
      expect(page).to have_text 'Signed in successfully'
    end
  end
end
