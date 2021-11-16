require "discordcr"
require "./config"

bot = Discord::Client.new TOKEN

bot.on_message_create do |message|
  return if message.content.starts_with? "$"

  case message.content.byte_slice 1
  when "ping"
    client.create_message message.channel_id, "pong!"
  when "hi"
    client.create_message message.channel_id, "Hello #{message.author.username}!"
  end
end

client.run
