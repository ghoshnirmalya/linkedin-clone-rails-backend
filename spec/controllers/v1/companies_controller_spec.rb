require "rails_helper"

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.
#
# Also compared to earlier versions of this generator, there are no longer any
# expectations of assigns and templates rendered. These features have been
# removed from Rails core in Rails 5, but can be added back in via the
# `rails-controller-testing` gem.

RSpec.describe V1::CompaniesController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # Company. As you add validations to Company, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    {
      attributes: {
        name: "My amazing company",
      },
    }
  }

  let(:invalid_attributes) {
    {
      attributes: {
        name: "",
      },
    }
  }

  def authorization_header(payload)
    JsonWebToken.encode(user_id: payload.id)
  end

  describe "GET #index" do
    it "returns a success response" do
      user = FactoryBot.create(:user)

      request.headers["HTTP_AUTHORIZATION"] = authorization_header(user)

      get :index, {format: :json}

      expect(response).to be_successful
    end

    it "returns a link object" do
      user = FactoryBot.create(:user)
      companies = FactoryBot.create_list(:company, 100)

      request.headers["HTTP_AUTHORIZATION"] = authorization_header(user)

      get :index, {format: :json}

      expect(JSON.parse(response.body)["links"]).to be_present
    end

    it "data of two pages shouldn't be same" do
      user = FactoryBot.create(:user)
      companies = FactoryBot.create_list(:company, 100)

      request.headers["HTTP_AUTHORIZATION"] = authorization_header(user)

      get :index, {format: :json, params: {page: 1}}

      response_first = response

      get :index, {format: :json, params: {page: 2}}

      response_second = response

      expect(JSON.parse(response_first.body)["links"]).to_not eq(JSON.parse(response_second.body)["links"])
    end

    it "throws 401 if Authorization header isn't passed" do
      get :index, {format: :json}

      expect(response).to have_http_status(:unauthorized)
    end

    context "without search params" do
      it "returns a list of 10 companies" do
        user = FactoryBot.create(:user)
        companies = FactoryBot.create_list(:company, 100)

        request.headers["HTTP_AUTHORIZATION"] = authorization_header(user)

        get :index, {format: :json}

        expect(JSON.parse(response.body)["data"].count).to eq(10)
      end
    end

    context "with search params" do
      it "returns a list of lesser than or equals to 10 companies" do
        user = FactoryBot.create(:user)
        companies = FactoryBot.create_list(:company, 100)

        request.headers["HTTP_AUTHORIZATION"] = authorization_header(user)

        get :index, {format: :json, params: {search: "a"}}

        expect(JSON.parse(response.body)["data"].count).to be <= 10
      end

      it "returns a list of 10 companies" do
        user = FactoryBot.create(:user)
        companies = FactoryBot.create_list(:company, 100, name: "Company A")

        request.headers["HTTP_AUTHORIZATION"] = authorization_header(user)

        get :index, {format: :json, params: {search: "Company A"}}

        expect(JSON.parse(response.body)["data"].count).to eq(10)
      end

      it "returns a list of 0 companies" do
        user = FactoryBot.create(:user)
        companies = FactoryBot.create_list(:company, 100, name: "Company B")

        request.headers["HTTP_AUTHORIZATION"] = authorization_header(user)

        get :index, {format: :json, params: {search: "Company A"}}

        expect(JSON.parse(response.body)["data"].count).to eq(0)
      end
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      user = FactoryBot.create(:user)
      company = FactoryBot.create(:company)

      request.headers["HTTP_AUTHORIZATION"] = authorization_header(user)

      get :show, params: {id: company.to_param}

      expect(response).to be_successful
    end

    it "throws 401 if Authorization header isn't passed" do
      company = FactoryBot.create(:company)

      get :show, params: {id: company.to_param}

      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        {
          attributes: {
            name: "My new amazing company",
          },
        }
      }

      it "updates the requested company" do
        user = FactoryBot.create(:user)
        company = FactoryBot.create(:company)

        request.headers["HTTP_AUTHORIZATION"] = authorization_header(user)

        put :update, params: {id: company.to_param, data: new_attributes}

        company.reload

        expect(company.name).to eq("My new amazing company")
      end

      it "renders a JSON response with the company" do
        user = FactoryBot.create(:user)
        company = FactoryBot.create(:company)

        request.headers["HTTP_AUTHORIZATION"] = authorization_header(user)

        put :update, params: {id: company.to_param, data: new_attributes}

        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq("application/vnd.api+json")
      end

      it "throws 401 if Authorization header isn't passed" do
        company = FactoryBot.create(:company)

        put :update, params: {id: company.to_param, data: new_attributes}

        expect(response).to have_http_status(:unauthorized)
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the company" do
        user = FactoryBot.create(:user)
        company = FactoryBot.create(:company)

        request.headers["HTTP_AUTHORIZATION"] = authorization_header(user)

        put :update, params: {id: company.to_param, data: invalid_attributes}

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/vnd.api+json")
      end

      it "throws 401 if Authorization header isn't passed" do
        company = FactoryBot.create(:company)

        put :update, params: {id: company.to_param, data: invalid_attributes}

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested company" do
      user = FactoryBot.create(:user)
      company = FactoryBot.create(:company)

      request.headers["HTTP_AUTHORIZATION"] = authorization_header(user)

      expect {
        delete :destroy, {format: :json, params: {id: company.to_param}}
      }.to change(Company, :count).by(-1)
    end

    it "throws 401 if Authorization header isn't passed" do
      company = FactoryBot.create(:company)

      delete :destroy, params: {id: company.to_param}

      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Company" do
        user = FactoryBot.create(:user)

        request.headers["HTTP_AUTHORIZATION"] = authorization_header(user)

        post :create, params: {data: valid_attributes}

        expect(Company.count).to eq(1)
      end

      it "renders a JSON response with the new company" do
        user = FactoryBot.create(:user)

        request.headers["HTTP_AUTHORIZATION"] = authorization_header(user)

        post :create, params: {data: valid_attributes}

        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq("application/vnd.api+json")
      end

      it "throws 401 if Authorization header isn't passed" do
        post :create, params: {data: valid_attributes}

        expect(response).to have_http_status(:unauthorized)
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new company" do
        user = FactoryBot.create(:user)

        request.headers["HTTP_AUTHORIZATION"] = authorization_header(user)

        post :create, params: {data: invalid_attributes}

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/vnd.api+json")
      end

      it "throws 401 if Authorization header isn't passed" do
        post :create, params: {data: valid_attributes}

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
