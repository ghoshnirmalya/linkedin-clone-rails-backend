require "rails_helper"

RSpec.describe V1::UsersController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/v1/users").to route_to("v1/users#index")
    end


    it "routes to #show" do
      expect(:get => "/v1/users/1").to route_to("v1/users#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/v1/users").to route_to("v1/users#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/v1/users/1").to route_to("v1/users#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/v1/users/1").to route_to("v1/users#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/v1/users/1").to route_to("v1/users#destroy", :id => "1")
    end

  end
end
