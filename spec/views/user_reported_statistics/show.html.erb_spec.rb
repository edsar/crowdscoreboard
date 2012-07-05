require 'spec_helper'

describe "user_reported_statistics/show" do
  before(:each) do
    @user_reported_statistic = assign(:user_reported_statistic, stub_model(UserReportedStatistic,
      :statistic_type => nil,
      :game => nil,
      :team_id => nil,
      :player_id => nil,
      :user_id => nil
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
