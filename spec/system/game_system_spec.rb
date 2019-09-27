require 'rails_helper'

describe Game do
  context 'when a player is logged in' do
    before { sign_in player }

    let(:player) { create :player }
    
    it 'they can create a new game' do
      # As a logged in Player
      # When I Visit /
      visit '/'
      # on game index page...
      
      # and Click on New Game
      click_on 'New Game'
      # on game new page...
      
      # I see a form with game details
      expect(page).to have_field('Name')
      # and a chat box
      expect(page).to have_selector(:id, "chat_window")
      # And a start game button
      expect(page).to have_button('Start Game')
      
      # And filling out the fields will result in a game being created
      fill_in 'Name', with: 'Game Name'
      click_on 'Start Game'
      # on game show page...
      
      expect(page).to have_text 'Game was successfully created.'
      within("#main_container") do
        # Player is listed as owner
        expect(page).to have_text player.email
      end
      
      # Now / will include the new game in the list
      visit '/'
      # on game index page...
      
      within("#main_container") do
        expect(page).to have_text player.email
        
        # As the creator of the game
        # the show, edit, and destroy buttons are visible
        expect(page).to have_link 'Show'
        expect(page).to have_link 'Edit'
        expect(page).to have_link 'Destroy'
      end
      
    end
    
    context 'When a game exists' do
      let!(:game_1) { create(:game) }

      it 'they can join an existing game' do
        visit '/'
        # on game index page...
        
        # As a logged in Player
        # When there is an existing game
        
        within("#main_container") do
          # They can see the show button for the game
          expect(page).to have_text 'Show'
          # They cannot see the edit and destroy buttons
          expect(page).to_not have_text 'Edit'
          expect(page).to_not have_text 'Destroy'
          
          # Clicking on Join will add the logged in player as a participant
          click_on 'Join'
        end
        # on game show page...
        
        # Taken to the game show page and made a participant
        expect(page).to have_text 'Successfully joined the game.'
        
        within("#main_container") do
          # The player will be listed as a participant
          expect(page).to have_text player.email
        end
        
        # The player will be listed as a participant on the games list page too
        visit '/'
        # on game index page...
        
        within("#main_container") do
          # The player will be listed as a participant
          expect(page).to have_text player.email
          
          # The Join button will not be visible
          expect(page).to_not have_link 'Join'
          
          # Clicking Join again will redirect to the game show page and not add participant again
          click_on 'Show'
        end
        # Back on game show page...
        
        within("#main_container") do
          # The player will be listed as a participant only once
          expect(page).to have_content(player.email, count: 1)
          
          # There will be no Join button while they are a participant
          expect(page).to_not have_content 'Join'
          
          # The player can remove themselves from the participant list
          expect(page).to have_text 'Leave Game'
          
          # Clicking the Leave Game link will remove them from the participant list
          click_on 'Leave Game'
        end
        # on game show page...
        
        expect(page).to have_text 'Successfully left the game.'
        
        within("#main_container") do
          # The player will be listed as a participant
          expect(page).to_not have_text player.email
          
          # The Join button will now be available
          expect(page).to have_text 'Join'
          
          # Clicking Join will add the player as a participant to the game and reload the page
          click_on 'Join'
        end
        # on game show page...
        
        expect(page).to have_text 'Successfully joined the game.'
        
        within("#main_container") do
          # The player will be listed as a participant
          expect(page).to have_text player.email
        end
      end
    end
  end
  
  context 'when no player is logged in' do
      context 'when a game exists' do
        let!(:game_1) { create(:game) }
        
        it 'they can only view the list of games' do
          # a visitor not signed in has no interaction with games.
          visit '/'
          # on game show page...
          
          within("#main_container") do
            expect(page).to have_text 'Games'
            # The test game basic info does show up
            expect(page).to have_text 'Owner:'
            expect(page).to have_text game_1.owner.email
            expect(page).to_not have_text 'New Game'
            expect(page).to_not have_text 'Join'
            expect(page).to_not have_text 'Show'
            expect(page).to_not have_text 'Edit'
            expect(page).to_not have_text 'Destroy'
          end
        end
      end
  end
end
