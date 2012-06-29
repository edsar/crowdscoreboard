require 'spec_helper'

describe "statistic_types/edit" do
  before(:each) do
    @statistic_type = assign(:statistic_type, stub_model(StatisticType,
      :code => "MyString",
      :points => ""
    ))
  end

  it "renders the edit statistic_type form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => statistic_types_path(@statistic_type), :method => "post" do
      assert_select "input#statistic_type_code", :name => "statistic_type[code]"
      assert_select "input#statistic_type_points", :name => "statistic_type[points]"
    end
  end
end
