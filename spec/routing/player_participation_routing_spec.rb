require "rails_helper"

RSpec.describe PlayerParticipationController, type: :routing do
  describe "routing" do
    it "routes to #create" do
      expect(:post => "/player_participation").to route_to("player_participation#create")
    end

    it "routes to #destroy" do
      expect(:delete => "/player_participation/1").to route_to("player_participation#destroy", :game => "1")
    end
  end
end
