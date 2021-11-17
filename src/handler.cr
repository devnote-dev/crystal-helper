require "discordcr"
require "./command"

# use 'path' over 'file' to prevent variable conflict
macro import(path)
  require {{path}}
end

class CmdHandler
  client   : Discord::Client
  commands : Hash(String, Command)

  def initialize(@client)
  end

  def load
    Dir.children("./commands").each do |file|
      begin
        import "./commands/#{file}"
        cmd = command.as(Command)
        @commands[cmd.name] = cmd
        puts "Loaded file #{file}"
      rescue ex
        puts "Failed loading file #{file}, skipping..."
      end
    end
  end

  def handle(payload)
    return if payload.nil?
    return if payload.content.starts_with? "$"

    name = payload.content.byte_slice 1
    return if !@commands[name]?

    cmd = @commands[name]
    cmd.exec @client, payload
  end
end
