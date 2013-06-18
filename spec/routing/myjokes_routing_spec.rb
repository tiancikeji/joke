require "spec_helper"

describe MyjokesController do
  describe "routing" do

    it "routes to #index" do
      get("/myjokes").should route_to("myjokes#index")
    end

    it "routes to #new" do
      get("/myjokes/new").should route_to("myjokes#new")
    end

    it "routes to #show" do
      get("/myjokes/1").should route_to("myjokes#show", :id => "1")
    end

    it "routes to #edit" do
      get("/myjokes/1/edit").should route_to("myjokes#edit", :id => "1")
    end

    it "routes to #create" do
      post("/myjokes").should route_to("myjokes#create")
    end

    it "routes to #update" do
      put("/myjokes/1").should route_to("myjokes#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/myjokes/1").should route_to("myjokes#destroy", :id => "1")
    end

  end
end
