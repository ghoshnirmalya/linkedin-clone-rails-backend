module V1
  class MessagesController < ApplicationController

    # GET /messages
    def index
      @messages = Message.where(conversation_id: params[:conversation_id]).search(params[:search]).page(params[:page])

      render json: @messages
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

    private

    # Only allow a trusted parameter "white list" through.
    def message_params
      params.require(:data)
        .require(:attributes)
        .permit(:body, :conversation_id, :user_id, :read)
    end
  end
end
