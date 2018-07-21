require "rails_helper"

RSpec.describe V1::MessagesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/v1/messages").to route_to("v1/messages#index")
    end

    it "routes to #show" do
      expect(:get => "/v1/messages/1").to route_to("v1/messages#show", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/v1/messages").to route_to("v1/messages#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/v1/messages/1").to route_to("v1/messages#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/v1/messages/1").to route_to("v1/messages#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/v1/messages/1").to route_to("v1/messages#destroy", :id => "1")
    end
  end
end
