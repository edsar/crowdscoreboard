require 'spec_helper'

describe "game_rosters/edit" do
  before(:each) do
    @game_roster = assign(:game_roster, stub_model(GameRoster))
  end

  it "renders the edit game_roster form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => game_rosters_path(@game_roster), :method => "post" do
    end
  end
end
