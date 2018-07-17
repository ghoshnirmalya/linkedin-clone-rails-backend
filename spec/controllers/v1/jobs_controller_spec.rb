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

RSpec.describe V1::JobsController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # Job. As you add validations to Job, be sure to
  # adjust the attributes here as well.

  let(:invalid_attributes) {
    {
      attributes: {
        title: "",
        description: "",
        company_id: 0,
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

    it "throws 401 if Authorization header isn't passed" do
      get :index, {format: :json}

      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      user = FactoryBot.create(:user)
      job = FactoryBot.create(:job)

      request.headers["HTTP_AUTHORIZATION"] = authorization_header(user)

      get :show, params: {id: job.to_param}

      expect(response).to be_successful
    end

    it "throws 401 if Authorization header isn't passed" do
      job = FactoryBot.create(:job)

      get :show, params: {id: job.to_param}

      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      it "updates the requested job" do
        user = FactoryBot.create(:user)
        company = FactoryBot.create(:company)
        job = FactoryBot.create(:job)

        request.headers["HTTP_AUTHORIZATION"] = authorization_header(user)

        put :update, params: {id: job.to_param, data: {
                       attributes: {
                         title: "Web Developer",
                         description: "We're looking for Backend people",
                         company_id: company.id,
                       },
                     }}

        job.reload

        expect(job.title).to eq("Web Developer")
        expect(job.description).to eq("We're looking for Backend people")
        expect(job.company).to eq(company)
      end

      it "renders a JSON response with the job" do
        user = FactoryBot.create(:user)
        company = FactoryBot.create(:company)
        job = FactoryBot.create(:job)

        request.headers["HTTP_AUTHORIZATION"] = authorization_header(user)

        put :update, params: {id: job.to_param, data: {
                       attributes: {
                         title: "Web Developer",
                         description: "We're looking for Backend people",
                         company_id: company.id,
                       },
                     }}

        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq("application/vnd.api+json")
      end

      it "throws 401 if Authorization header isn't passed" do
        job = FactoryBot.create(:job)
        company = FactoryBot.create(:company)

        put :update, params: {id: job.to_param, data: {
                       attributes: {
                         title: "Web Developer",
                         description: "We're looking for Backend people",
                         company_id: company.id,
                       },
                     }}

        expect(response).to have_http_status(:unauthorized)
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the job" do
        user = FactoryBot.create(:user)
        job = FactoryBot.create(:job)

        request.headers["HTTP_AUTHORIZATION"] = authorization_header(user)

        put :update, params: {id: job.to_param, data: invalid_attributes}

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/vnd.api+json")
      end

      it "throws 401 if Authorization header isn't passed" do
        job = FactoryBot.create(:job)

        put :update, params: {id: job.to_param, data: invalid_attributes}

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested job" do
      user = FactoryBot.create(:user)
      job = FactoryBot.create(:job)

      request.headers["HTTP_AUTHORIZATION"] = authorization_header(user)

      expect {
        delete :destroy, {format: :json, params: {id: job.to_param}}
      }.to change(Job, :count).by(-1)
    end

    it "throws 401 if Authorization header isn't passed" do
      job = FactoryBot.create(:job)

      delete :destroy, params: {id: job.to_param}

      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Job" do
        user = FactoryBot.create(:user)
        company = FactoryBot.create(:company)

        request.headers["HTTP_AUTHORIZATION"] = authorization_header(user)

        post :create, params: {data: {
                        attributes: {
                          title: "Web Developer",
                          description: "We're looking for Backend people",
                          company_id: company.id,
                        },
                      }}

        expect(Company.count).to eq(1)
      end

      it "renders a JSON response with the new job" do
        user = FactoryBot.create(:user)
        company = FactoryBot.create(:company)

        request.headers["HTTP_AUTHORIZATION"] = authorization_header(user)

        post :create, params: {data: {
                        attributes: {
                          title: "Web Developer",
                          description: "We're looking for Backend people",
                          company_id: company.id,
                        },
                      }}

        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq("application/vnd.api+json")
      end

      it "throws 401 if Authorization header isn't passed" do
        company = FactoryBot.create(:company)

        post :create, params: {data: {
                        attributes: {
                          title: "Web Developer",
                          description: "We're looking for Backend people",
                          company_id: company.id,
                        },
                      }}

        expect(response).to have_http_status(:unauthorized)
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new job" do
        user = FactoryBot.create(:user)

        request.headers["HTTP_AUTHORIZATION"] = authorization_header(user)

        post :create, params: {data: invalid_attributes}

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/vnd.api+json")
      end

      it "throws 401 if Authorization header isn't passed" do
        company = FactoryBot.create(:company)

        post :create, params: {data: {
                        attributes: {
                          title: "Web Developer",
                          description: "We're looking for Backend people",
                          company_id: company.id,
                        },
                      }}

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
