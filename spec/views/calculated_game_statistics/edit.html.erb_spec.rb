require 'spec_helper'

describe "calculated_game_statistics/edit" do
  before(:each) do
    @calculated_game_statistic = assign(:calculated_game_statistic, stub_model(CalculatedGameStatistic))
  end

  it "renders the edit calculated_game_statistic form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => calculated_game_statistics_path(@calculated_game_statistic), :method => "post" do
    end
  end
end
