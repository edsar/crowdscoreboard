require 'spec_helper'

describe "game_rosters/index" do
  before(:each) do
    assign(:game_rosters, [
      stub_model(GameRoster),
      stub_model(GameRoster)
    ])
  end

  it "renders a list of game_rosters" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
