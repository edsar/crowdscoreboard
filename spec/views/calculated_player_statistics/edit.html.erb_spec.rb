require 'spec_helper'

describe "calculated_player_statistics/edit" do
  before(:each) do
    @calculated_player_statistic = assign(:calculated_player_statistic, stub_model(CalculatedPlayerStatistic))
  end

  it "renders the edit calculated_player_statistic form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => calculated_player_statistics_path(@calculated_player_statistic), :method => "post" do
    end
  end
end
