require "rails_helper"

RSpec.describe RollsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/rolls").to route_to("rolls#index")
    end

    it "routes to #show" do
      expect(:get => "/rolls/1").to route_to("rolls#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/rolls").to route_to("rolls#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/rolls/1").to route_to("rolls#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/rolls/1").to route_to("rolls#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/rolls/1").to route_to("rolls#destroy", :id => "1")
    end
  end
end
