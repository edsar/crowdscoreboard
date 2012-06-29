require 'spec_helper'

describe "calculated_game_statistics/show" do
  before(:each) do
    @calculated_game_statistic = assign(:calculated_game_statistic, stub_model(CalculatedGameStatistic))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
