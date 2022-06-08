class OnlineChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'online_channel'
    current_user.update(online: true)
    broadcast_users
  end

  def unsubscribed
    stream_from 'online_channel'
    current_user.update(online: false)
    broadcast_users
  end

  private

  def broadcast_users
    ActionCable.server.broadcast('online_channel', users: User.online.pluck(:nickname))
  end
end
