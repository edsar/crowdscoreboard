require 'spec_helper'

describe "game_rosters/show" do
  before(:each) do
    @game_roster = assign(:game_roster, stub_model(GameRoster))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
