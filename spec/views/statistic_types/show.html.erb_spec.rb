require 'spec_helper'

describe "statistic_types/show" do
  before(:each) do
    @statistic_type = assign(:statistic_type, stub_model(StatisticType,
      :code => "Code",
      :points => ""
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Code/)
    rendered.should match(//)
  end
end
