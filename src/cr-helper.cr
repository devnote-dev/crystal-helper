require "discordcr"
require "./config"
require "./handler"

bot = Discord::Client.new TOKEN
handler = Handler.new

bot.on_message_create { |msg| handler.handle msg }

client.run
