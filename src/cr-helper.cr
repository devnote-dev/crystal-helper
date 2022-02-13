require "discordcr"
require "yaml"

require "./commands/ping.cr"

config = File.open("./config.yml") { |f| YAML.parse f }

bot = Discord::Client.new(config["token"].as_s)

bot.on_message_create do |message|
	next unless message.content.starts_with? "$"

	cmd = message.content.byte_slice(1).split(separator: " ", remove_empty: true)[0]
	next unless cmd.size

	case cmd
	when "ping"
		cmd_ping bot, message
	else
		bot.create_message(message.channel_id, "command '#{cmd}' not found!")
	end
end

bot.run
