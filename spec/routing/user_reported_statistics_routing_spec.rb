require "spec_helper"

describe UserReportedStatisticsController do
  describe "routing" do

    it "routes to #index" do
      get("/user_reported_statistics").should route_to("user_reported_statistics#index")
    end

    it "routes to #new" do
      get("/user_reported_statistics/new").should route_to("user_reported_statistics#new")
    end

    it "routes to #show" do
      get("/user_reported_statistics/1").should route_to("user_reported_statistics#show", :id => "1")
    end

    it "routes to #edit" do
      get("/user_reported_statistics/1/edit").should route_to("user_reported_statistics#edit", :id => "1")
    end

    it "routes to #create" do
      post("/user_reported_statistics").should route_to("user_reported_statistics#create")
    end

    it "routes to #update" do
      put("/user_reported_statistics/1").should route_to("user_reported_statistics#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/user_reported_statistics/1").should route_to("user_reported_statistics#destroy", :id => "1")
    end

  end
end
