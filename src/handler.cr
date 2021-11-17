require "./command"

macro import(file)
  require {{file}}
end

class CmdHandler
  commands : Hash(String, Command)

  def initialize
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
end
