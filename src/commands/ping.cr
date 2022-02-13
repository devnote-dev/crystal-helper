def cmd_ping(client, message)
  msg = client.create_message(message.channel_id, "pong!")
  taken = Time.utc - message.timestamp
  client.edit_message(
    message.channel_id, msg.id,
    "API: #{taken.total_milliseconds}ms"
  )
end
