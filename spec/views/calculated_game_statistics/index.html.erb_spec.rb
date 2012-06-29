require 'spec_helper'

describe "calculated_game_statistics/index" do
  before(:each) do
    assign(:calculated_game_statistics, [
      stub_model(CalculatedGameStatistic),
      stub_model(CalculatedGameStatistic)
    ])
  end

  it "renders a list of calculated_game_statistics" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
