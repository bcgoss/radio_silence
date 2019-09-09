require 'rails_helper'

shared_examples 'Navbar when not logged in' do |page_url|
    it_behaves_like 'Navbar features always present', page_url
    
    it 'Has a way for a player to sign up' do
        visit page_url
        
        within("#navbar") do
            expect(page).to have_link 'Sign up'
            click_on 'Sign up'
        end
        
        within("#main_container") do
            expect(page).to have_text 'Sign up'
        end
    end
    
    it 'Has a way for a player to log in' do
        visit page_url
        
        within("#navbar") do
            expect(page).to have_link 'Sign in'
            click_on 'Sign in'
        end
        
        within("#main_container") do
            expect(page).to have_text 'Sign in'
        end
    end
end

shared_examples 'Navbar when logged in' do |page_url|
    before { sign_in player }
    
    it_behaves_like 'Navbar features always present', page_url
    
    it 'displays the logged in player email address' do
        visit page_url
        
        within("#navbar") do
            expect(page).to have_text player.email
        end
    end
    
    it 'provides a way for the player to sign out' do
        visit page_url
        
        within("#navbar") do
            expect(page).to have_link 'Sign out'
            click_on 'Sign out'
        end

        expect(page).to have_text 'Signed out successfully.'
    end
end


shared_examples 'Navbar features always present' do |page_to_visit|
    it 'has a brand with the text Radio Silence' do
        visit page_to_visit

        within(".navbar-brand") do
           expect(page).to have_text 'Radio Silence'
        end
    end
    
    it 'has a Games link that works' do
       visit page_to_visit
       
        within(".nav-item") do
            expect(page).to have_link 'Games' 
            click_on 'Games'
        end
        
        within("#main_container") do
            expect(page).to have_text 'Games'
        end
    end
end