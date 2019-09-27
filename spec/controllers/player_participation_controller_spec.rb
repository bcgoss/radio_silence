require 'rails_helper'

RSpec.describe PlayerParticipationController, type: :controller do
    before do
        sign_in current_player
    end
    
    let(:current_player) { create(:player) }
    let(:game1) { create(:game) }
    let(:valid_session) { {} }
    let(:valid_attributes) { { game: game1, player: current_player } }
    let(:invalid_attributes) { { game: game1, player: nil } }

    describe 'POST #create' do
        context 'with valid params' do
            it 'creates a new player_participation' do
                 expect {
                     post :create, params: valid_attributes , session: valid_session
                 }.to change(PlayerParticipation, :count).by(1)
            end
            
            it 'redirects to the appropriate game show' do
                post :create, params: valid_attributes, session: valid_session
                expect(response).to redirect_to(Game.find(game1.id))
            end
        end

        context 'with invalid params' do
            it 'returns a success response' do
                post :create, params: invalid_attributes, session: valid_session
                expect(response).to be_successful
            end
        end
    end
    
    describe "DELETE #destroy" do
        before do
            PlayerParticipation.create! valid_attributes
        end
        
        it 'destroys the requested record' do
           expect {
               delete :destroy, params: {game: game1, player: current_player}, session: valid_session
           }.to change(PlayerParticipation, :count).by(-1)
           
           expect(response).to redirect_to(game1)
        end
    end
end
