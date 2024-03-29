require 'spec_helper'

describe "users/new" do
  before(:each) do
    assign(:user, stub_model(User,
      :twitter_id => "MyString",
      :twitter_screen_name => "MyString"
    ).as_new_record)
  end

  it "renders new user form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => users_path, :method => "post" do
      assert_select "input#user_twitter_id", :name => "user[twitter_id]"
      assert_select "input#user_twitter_screen_name", :name => "user[twitter_screen_name]"
    end
  end
end
