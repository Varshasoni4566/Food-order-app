class SendPushNotificationJob < ApplicationJob
  queue_as :default

  def perform(device_token, message)
    $fcm.send(device_token, { data: { message: message } })
  end
end
