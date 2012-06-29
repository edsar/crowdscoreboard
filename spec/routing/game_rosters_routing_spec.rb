require "spec_helper"

describe GameRostersController do
  describe "routing" do

    it "routes to #index" do
      get("/game_rosters").should route_to("game_rosters#index")
    end

    it "routes to #new" do
      get("/game_rosters/new").should route_to("game_rosters#new")
    end

    it "routes to #show" do
      get("/game_rosters/1").should route_to("game_rosters#show", :id => "1")
    end

    it "routes to #edit" do
      get("/game_rosters/1/edit").should route_to("game_rosters#edit", :id => "1")
    end

    it "routes to #create" do
      post("/game_rosters").should route_to("game_rosters#create")
    end

    it "routes to #update" do
      put("/game_rosters/1").should route_to("game_rosters#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/game_rosters/1").should route_to("game_rosters#destroy", :id => "1")
    end

  end
end
