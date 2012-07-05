require 'spec_helper'

describe "user_reported_statistics/index" do
  before(:each) do
    assign(:user_reported_statistics, [
      stub_model(UserReportedStatistic,
        :statistic_type => nil,
        :game => nil,
        :team_id => nil,
        :player_id => nil,
        :user_id => nil
      ),
      stub_model(UserReportedStatistic,
        :statistic_type => nil,
        :game => nil,
        :team_id => nil,
        :player_id => nil,
        :user_id => nil
      )
    ])
  end

  it "renders a list of user_reported_statistics" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
