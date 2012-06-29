require 'spec_helper'

describe "users/edit" do
  before(:each) do
    @user = assign(:user, stub_model(User,
      :twitter_id => "MyString",
      :twitter_screen_name => "MyString"
    ))
  end

  it "renders the edit user form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => users_path(@user), :method => "post" do
      assert_select "input#user_twitter_id", :name => "user[twitter_id]"
      assert_select "input#user_twitter_screen_name", :name => "user[twitter_screen_name]"
    end
  end
end
