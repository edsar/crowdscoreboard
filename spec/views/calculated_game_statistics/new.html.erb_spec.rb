require 'spec_helper'

describe "calculated_game_statistics/new" do
  before(:each) do
    assign(:calculated_game_statistic, stub_model(CalculatedGameStatistic).as_new_record)
  end

  it "renders new calculated_game_statistic form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => calculated_game_statistics_path, :method => "post" do
    end
  end
end
