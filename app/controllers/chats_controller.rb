class ChatsController < ApplicationController
  def index
    @users = current_user.followings | current_user.followers
  end

  def create
    seek_chat
    return redirect_to(chat_path(id: @chat.id, destination_id: fetch_destination.id)) if @chat.present?

    @chat = Chat.new(user_open_chat: current_user, user_destination_chat: fetch_destination)

    return redirect_to(chat_path(id: @chat.id, destination_id: fetch_destination.id)) if @chat.save

    @users = current_user.followings | current_user.followers
    render :index
  end

  def show
    seek_chat
    redirect_to chats_path if @chat.nil?

    @destination = fetch_destination
    @chat_messages = @chat.chat_messages.order(created_at: :desc)
  end

  private

  def fetch_destination
    @destination ||= User.find(params[:destination_id])
  end

  def seek_chat
    opt_a_b = '(chats.user_open_chat_id = :open AND chats.user_destination_chat_id = :destination)'
    opt_b_a = '(chats.user_open_chat_id = :destination AND chats.user_destination_chat_id = :open)'
    @chat = Chat.where("#{opt_a_b} OR #{opt_b_a}", open: current_user.id, destination: fetch_destination.id).first
  end
end

