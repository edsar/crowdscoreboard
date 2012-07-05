require 'spec_helper'

describe "UserReportedStatistics" do
  describe "GET /user_reported_statistics" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get user_reported_statistics_path
      response.status.should be(200)
    end
  end
end
