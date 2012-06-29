require 'spec_helper'

describe "statistic_types/index" do
  before(:each) do
    assign(:statistic_types, [
      stub_model(StatisticType,
        :code => "Code",
        :points => ""
      ),
      stub_model(StatisticType,
        :code => "Code",
        :points => ""
      )
    ])
  end

  it "renders a list of statistic_types" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Code".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
  end
end
