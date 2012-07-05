require 'spec_helper'

describe "user_reported_statistics/edit" do
  before(:each) do
    @user_reported_statistic = assign(:user_reported_statistic, stub_model(UserReportedStatistic,
      :statistic_type => nil,
      :game => nil,
      :team_id => nil,
      :player_id => nil,
      :user_id => nil
    ))
  end

  it "renders the edit user_reported_statistic form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => user_reported_statistics_path(@user_reported_statistic), :method => "post" do
      assert_select "input#user_reported_statistic_statistic_type", :name => "user_reported_statistic[statistic_type]"
      assert_select "input#user_reported_statistic_game", :name => "user_reported_statistic[game]"
      assert_select "input#user_reported_statistic_team_id", :name => "user_reported_statistic[team_id]"
      assert_select "input#user_reported_statistic_player_id", :name => "user_reported_statistic[player_id]"
      assert_select "input#user_reported_statistic_user_id", :name => "user_reported_statistic[user_id]"
    end
  end
end
