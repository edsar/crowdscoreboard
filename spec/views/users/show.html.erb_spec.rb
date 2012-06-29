require 'spec_helper'

describe "users/show" do
  before(:each) do
    @user = assign(:user, stub_model(User,
      :twitter_id => "Twitter",
      :twitter_screen_name => "Twitter Screen Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Twitter/)
    rendered.should match(/Twitter Screen Name/)
  end
end
