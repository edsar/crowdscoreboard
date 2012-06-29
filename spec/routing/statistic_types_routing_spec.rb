require "spec_helper"

describe StatisticTypesController do
  describe "routing" do

    it "routes to #index" do
      get("/statistic_types").should route_to("statistic_types#index")
    end

    it "routes to #new" do
      get("/statistic_types/new").should route_to("statistic_types#new")
    end

    it "routes to #show" do
      get("/statistic_types/1").should route_to("statistic_types#show", :id => "1")
    end

    it "routes to #edit" do
      get("/statistic_types/1/edit").should route_to("statistic_types#edit", :id => "1")
    end

    it "routes to #create" do
      post("/statistic_types").should route_to("statistic_types#create")
    end

    it "routes to #update" do
      put("/statistic_types/1").should route_to("statistic_types#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/statistic_types/1").should route_to("statistic_types#destroy", :id => "1")
    end

  end
end
