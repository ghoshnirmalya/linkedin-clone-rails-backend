module V1
  class ConversationsController < ApplicationController
    before_action :set_conversation, only: [:show, :update, :destroy]

    # GET /conversations
    def index
      @current_user = AuthorizeApiRequest.call(request.headers).result

      @conversations = Conversation.where(sender: @current_user).page(params[:page])

      render json: @conversations
    end

    # GET /conversations/1
    def show
      render json: @conversation
    end

    # POST /conversations
    def create
      @conversation = Conversation.new(conversation_params)

      if @conversation.save
        render json: @conversation, status: :created
      else
        render json: @conversation, status: :unprocessable_entity, serializer: ActiveModel::Serializer::ErrorSerializer
      end
    end

    # PATCH/PUT /conversations/1
    def update
      if @conversation.update(conversation_params)
        render json: @conversation
      else
        render json: @conversation, status: :unprocessable_entity, serializer: ActiveModel::Serializer::ErrorSerializer
      end
    end

    # DELETE /conversations/1
    def destroy
      @conversation.destroy
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_conversation
      @conversation = Conversation.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def conversation_params
      params.require(:data)
        .require(:attributes)
        .permit(:sender_id, :recipient_id)
    end
  end
end
