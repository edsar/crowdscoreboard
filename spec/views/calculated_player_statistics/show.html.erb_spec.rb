require 'spec_helper'

describe "calculated_player_statistics/show" do
  before(:each) do
    @calculated_player_statistic = assign(:calculated_player_statistic, stub_model(CalculatedPlayerStatistic))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
