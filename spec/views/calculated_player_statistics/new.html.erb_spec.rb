require 'spec_helper'

describe "calculated_player_statistics/new" do
  before(:each) do
    assign(:calculated_player_statistic, stub_model(CalculatedPlayerStatistic).as_new_record)
  end

  it "renders new calculated_player_statistic form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => calculated_player_statistics_path, :method => "post" do
    end
  end
end
