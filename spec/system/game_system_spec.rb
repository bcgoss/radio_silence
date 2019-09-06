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
    end
  end
end
