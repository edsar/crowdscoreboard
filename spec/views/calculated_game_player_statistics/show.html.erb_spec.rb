require 'spec_helper'

describe "calculated_game_player_statistics/show" do
  before(:each) do
    @calculated_game_player_statistic = assign(:calculated_game_player_statistic, stub_model(CalculatedGamePlayerStatistic,
      :game_id => "",
      :team_id => "",
      :player_id => "",
      :count => "",
      :stat_type => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    rendered.should match(//)
    rendered.should match(//)
    rendered.should match(//)
    rendered.should match(//)
  end
end
