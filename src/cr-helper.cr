require "discordcr"
require "yaml"

require "./commands/ping.cr"

config = File.open("./config.yml") do |file|
  YAML.parse file
end

bot = Discord::Client.new(config["token"].as_s)

bot.on_message_create do |message|
	next if !message.content.starts_with? "$"
	case message.content.byte_slice(1)
	when "ping"
		cmdPing bot, message
	else
		bot.create_message(message.channel_id, "command not found!")
	end
end

bot.run
