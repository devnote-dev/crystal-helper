require "discordcr"
require "yaml"

require "./commands/ping.cr"
require "./commands/args.cr"
require "./commands/run.cr"

config = File.open("./config.yml") { |f| YAML.parse f }

bot = Discord::Client.new(config["token"].as_s)

bot.on_ready do |_|
	bot.status_update status: "with Crystal docs"
end

bot.on_message_create do |message|
	next unless message.content.starts_with? "$"

	cmd = message.content.byte_slice(1).split(separator: " ", remove_empty: true)[0]
	next if cmd.size == 0

	case cmd
	when "ping"
		cmd_ping bot, message
	when "args"
		cmd_args bot, message
	when "run"
		cmd_run bot, message
	else
		next
	end
end

bot.run
