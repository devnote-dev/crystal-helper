require "../command"

command = Command.new(
  "ping",
  "Sends the bot ping",
  "ping",
  0
) do |client, message|
  msg = client.create_message message.channel_id, "pong!"
  time = Time.utc - message.timestamp
  client.edit_message(
    message.channel_id, msg.id,
    "API: #{time.total_milliseconds}ms"
  )
end
