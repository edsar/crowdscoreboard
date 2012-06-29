require 'spec_helper'

describe "calculated_game_player_statistics/edit" do
  before(:each) do
    @calculated_game_player_statistic = assign(:calculated_game_player_statistic, stub_model(CalculatedGamePlayerStatistic,
      :game_id => "",
      :team_id => "",
      :player_id => "",
      :count => "",
      :stat_type => nil
    ))
  end

  it "renders the edit calculated_game_player_statistic form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => calculated_game_player_statistics_path(@calculated_game_player_statistic), :method => "post" do
      assert_select "input#calculated_game_player_statistic_game_id", :name => "calculated_game_player_statistic[game_id]"
      assert_select "input#calculated_game_player_statistic_team_id", :name => "calculated_game_player_statistic[team_id]"
      assert_select "input#calculated_game_player_statistic_player_id", :name => "calculated_game_player_statistic[player_id]"
      assert_select "input#calculated_game_player_statistic_count", :name => "calculated_game_player_statistic[count]"
      assert_select "input#calculated_game_player_statistic_stat_type", :name => "calculated_game_player_statistic[stat_type]"
    end
  end
end
