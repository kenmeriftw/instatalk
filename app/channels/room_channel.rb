class RoomChannel < ApplicationCable::Channel
  def subscribed
    logger.info "Subscribed to RoomChannel, roomId: #{params[:roomId]}"

    @room = Room.find(params[:roomId])

    stream_from "room_channel_#{@room.id}"

    speak('message' => '* * * joined the room * * *')
  end

  def unsubscribed
    logger.info 'Unsubscribed from RoomChannel'

    speak('message' => '* * * has left the room * * *')
  end

  def speak(data)
    logger.info "RoomChannel, speak: #{data.inspect}"

    MessageService.new(body: data['message'], room: @room, user: current_user).perform
  end
end
