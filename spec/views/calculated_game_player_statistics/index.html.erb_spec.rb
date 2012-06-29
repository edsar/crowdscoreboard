require 'spec_helper'

describe "calculated_game_player_statistics/index" do
  before(:each) do
    assign(:calculated_game_player_statistics, [
      stub_model(CalculatedGamePlayerStatistic,
        :game_id => "",
        :team_id => "",
        :player_id => "",
        :count => "",
        :stat_type => nil
      ),
      stub_model(CalculatedGamePlayerStatistic,
        :game_id => "",
        :team_id => "",
        :player_id => "",
        :count => "",
        :stat_type => nil
      )
    ])
  end

  it "renders a list of calculated_game_player_statistics" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
