require "spec_helper"

describe CalculatedGamePlayerStatisticsController do
  describe "routing" do

    it "routes to #index" do
      get("/calculated_game_player_statistics").should route_to("calculated_game_player_statistics#index")
    end

    it "routes to #new" do
      get("/calculated_game_player_statistics/new").should route_to("calculated_game_player_statistics#new")
    end

    it "routes to #show" do
      get("/calculated_game_player_statistics/1").should route_to("calculated_game_player_statistics#show", :id => "1")
    end

    it "routes to #edit" do
      get("/calculated_game_player_statistics/1/edit").should route_to("calculated_game_player_statistics#edit", :id => "1")
    end

    it "routes to #create" do
      post("/calculated_game_player_statistics").should route_to("calculated_game_player_statistics#create")
    end

    it "routes to #update" do
      put("/calculated_game_player_statistics/1").should route_to("calculated_game_player_statistics#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/calculated_game_player_statistics/1").should route_to("calculated_game_player_statistics#destroy", :id => "1")
    end

  end
end
