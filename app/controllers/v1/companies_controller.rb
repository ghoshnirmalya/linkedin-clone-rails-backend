module V1
  class CompaniesController < ApplicationController
    before_action :set_company, only: [:show, :update, :destroy]

    # GET /companies
    def index
      @companies = Company.page(params[:page])

      render json: @companies
    end

    # GET /companies/1
    def show
      render json: @company
    end

    # POST /companies
    def create
      @company = Company.new(company_params)

      if @company.save
        render json: @company, status: :created
      else
        render json: @company, status: :unprocessable_entity, serializer: ActiveModel::Serializer::ErrorSerializer
      end
    end

    # PATCH/PUT /companies/1
    def update
      if @company.update(company_params)
        render json: @company
      else
        render json: @company, status: :unprocessable_entity, serializer: ActiveModel::Serializer::ErrorSerializer
      end
    end

    # DELETE /companies/1
    def destroy
      @company.destroy
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_company
      @company = Company.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def company_params
      params.require(:data)
        .require(:attributes)
        .permit(:name)
    end
  end
end
