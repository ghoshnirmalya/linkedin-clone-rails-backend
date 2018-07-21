module V1
  class MessagesController < ApplicationController
    before_action :set_message, only: [:show, :update, :destroy]

    # GET /messages
    def index
      @messages = Message.where(conversation_id: params[:conversation_id]).search(params[:search]).page(params[:page])

      render json: @messages
    end

    # GET /messages/1
    def show
      render json: @message
    end

    # POST /messages
    def create
      @message = Message.new(message_params)

      if @message.save
        render json: @message, status: :created
      else
        render json: @message, status: :unprocessable_entity, serializer: ActiveModel::Serializer::ErrorSerializer
      end
    end

    # PATCH/PUT /messages/1
    def update
      if @message.update(message_params)
        render json: @message
      else
        render json: @message, status: :unprocessable_entity, serializer: ActiveModel::Serializer::ErrorSerializer
      end
    end

    # DELETE /messages/1
    def destroy
      @message.destroy
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def message_params
      params.require(:data)
        .require(:attributes)
        .permit(:body, :conversation_id, :user_id, :read)
    end
  end
end
