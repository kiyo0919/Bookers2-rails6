class RoomsController < ApplicationController
  before_action :authenticate_user!
  def create
    @room = Room.create
    @entry1 = Entry.create(room_id: @room.id, user_id: current_user.id)
    @entry2 = Entry.create(room_id: @room.id, user_id: params[:entry][:user_id])
    redirect_to room_path(@room)
  end

  def show
    @room = Room.find(params[:id])
    if Entry.where(user_id: current_user.id, room_id: @room.id).present?
      @messages = @room.messages
      @message = Message.new
      @entries = @room.entries
      @entries.each do |entry|
        if entry.user != current_user
          @partner = entry.user
          break
        end
      end
    else
      redirect_back(fallback_location: root_path)
    end
  end

end
