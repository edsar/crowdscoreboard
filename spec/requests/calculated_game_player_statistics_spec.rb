require 'spec_helper'

describe "CalculatedGamePlayerStatistics" do
  describe "GET /calculated_game_player_statistics" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get calculated_game_player_statistics_path
      response.status.should be(200)
    end
  end
end
