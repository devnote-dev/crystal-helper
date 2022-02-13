require "discordcr"
require "yaml"

require "./commands/ping.cr"

config = File.open("./config.yml") do |file|
  YAML.parse file
end

bot = Discord::Client.new(config["token"].as_s)

bot.on_message_create do |message|
	next if !message.content.starts_with? "$"

	cmd = message.content.byte_slice(1).split(separator: " ", remove_empty: true)[0]
	case cmd
	when "ping"
		cmd_ping bot, message
	else
		bot.create_message(message.channel_id, "command '#{cmd}' not found!")
	end
end

bot.run
