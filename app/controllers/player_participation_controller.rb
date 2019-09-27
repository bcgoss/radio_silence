class PlayerParticipationController < ApplicationController
    # POST /player_participations
    def create
        return if player_participation_params[:game].blank? || player_participation_params[:player].blank?
        
        game = Game.find(player_participation_params[:game])
        player = Player.find(player_participation_params[:player])
        
        return if game.blank? || player.blank?
        
        if game.players.include?(player)
            redirect_to game, notice: 'Welcome back!'
        else
            game.players << player
            redirect_to game, notice: 'Successfully joined the game.'
        end
    end

    def destroy
        game = Game.find(player_participation_params[:game])

        participation = game.player_participations.find_by(player: current_player)
        
        participation.destroy
        
        redirect_to game, notice: 'Successfully left the game.'
    end
    
    
    private
    
    def player_participation_params
      params.permit(:game, :player, :_method, :authenticity_token)
    end
    
end
