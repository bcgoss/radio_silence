require 'rails_helper'

describe Game do
  context 'when a player is logged in' do
    before { sign_in player }

    let(:player) { create :player }
    
    it 'they can create a new game' do
      # As a logged in Player
      # When I Visit /
      visit '/'
      # and Click on New Game
      click_on 'New Game'
      # I see a form with game details
      expect(page).to have_field('Name')
      # and a chat box
      expect(page).to have_selector(:id, "chat_window")
      # And a start game button
      expect(page).to have_button('Start Game')
      
      # And filling out the fields will result in a game being created
      fill_in 'Name', with: 'Game Name'
      click_on 'Start Game'
      
      expect(page).to have_text 'Game was successfully created.'
      within("#main_container") do
        expect(page).to have_text player.email
      end
      
      # Now / will include the new game in the list
      visit '/'
      within("#main_container") do
        expect(page).to have_text player.email
      end
    end
  end
  
  context 'when no player is logged in' do
      
  end
end
