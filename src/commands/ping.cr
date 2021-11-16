require "../command"

command = Command.new(
  "ping",
  "Sends the bot ping",
  "ping",
  0
) do |client, ctx|
  client.create_message ctx.channel_id, "pong!"
end
