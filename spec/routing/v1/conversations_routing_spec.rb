require "rails_helper"

RSpec.describe V1::ConversationsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/v1/conversations").to route_to("v1/conversations#index")
    end

    it "routes to #show" do
      expect(:get => "/v1/conversations/1").to route_to("v1/conversations#show", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/v1/conversations").to route_to("v1/conversations#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/v1/conversations/1").to route_to("v1/conversations#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/v1/conversations/1").to route_to("v1/conversations#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/v1/conversations/1").to route_to("v1/conversations#destroy", :id => "1")
    end
  end
end
