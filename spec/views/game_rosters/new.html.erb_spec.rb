require 'spec_helper'

describe "game_rosters/new" do
  before(:each) do
    assign(:game_roster, stub_model(GameRoster).as_new_record)
  end

  it "renders new game_roster form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => game_rosters_path, :method => "post" do
    end
  end
end
