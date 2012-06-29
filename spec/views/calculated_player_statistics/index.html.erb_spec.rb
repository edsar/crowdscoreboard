require 'spec_helper'

describe "calculated_player_statistics/index" do
  before(:each) do
    assign(:calculated_player_statistics, [
      stub_model(CalculatedPlayerStatistic),
      stub_model(CalculatedPlayerStatistic)
    ])
  end

  it "renders a list of calculated_player_statistics" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
