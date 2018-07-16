require "rails_helper"

RSpec.describe V1::AuthenticationController, type: :controller do
  let(:valid_attributes) {
    {
      attributes: {
        name: "John Doe",
        email: "john@doe.com",
        password: "password",
      },
    }
  }

  let(:invalid_attributes) {
    {
      attributes: {
        email: "",
        password: "",
      },
    }
  }

  describe "#sign_up" do
    context "with valid params" do
      it "creates a new User" do
        post :sign_up, params: {data: valid_attributes}

        expect(User.count).to eq(1)
      end

      it "returns a valid token" do
        post :sign_up, params: {data: valid_attributes}

        expect(response).to be_successful
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)["auth_token"]).to eq("eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyfQ.MGDoh6fr29U1-DQo0o3myLlj3i2-fQclV9mQ1tDKIfw")
      end
    end

    context "with invalid params" do
      it "doesn't create a new User" do
        post :sign_up, params: {data: invalid_attributes}

        expect(User.count).to eq(0)
      end

      it "throws error" do
        post :sign_up, params: {data: invalid_attributes}

        expect(response).to have_http_status(:unauthorized)
        expect(response.body).to eq("{\"error\":{\"user_authentication\":[\"invalid credentials\"]}}")
      end
    end
  end

  describe "#sign_in" do
    context "with valid params" do
      it "returns a valid token" do
        user = User.create! valid_attributes

        post :sign_in, params: {data: valid_attributes}

        expect(response).to be_successful
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)["auth_token"]).to eq("eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjozfQ.IVXk2dJkHk4Vcc9lK1eQeOEfWmftLnrc5zhY311K8Q8")
      end

      it "doesn't create a new User" do
        user = User.create! valid_attributes

        post :sign_in, params: {data: valid_attributes}

        expect(User.count).to eq(1)
      end
    end

    context "with invalid params" do
      it "throws error" do
        post :sign_in, params: {data: invalid_attributes}

        expect(response).to have_http_status(:unauthorized)
        expect(response.body).to eq("{\"error\":{\"user_authentication\":[\"invalid credentials\"]}}")
      end
    end
  end
end
