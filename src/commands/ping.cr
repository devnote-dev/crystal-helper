def cmdPing(client, message)
  client.create_message message.channel_id, "pong!"
end
