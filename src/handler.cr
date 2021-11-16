require "./command"

class CmdHandler
  commands : Hash(String, Command)

  def initialize
  end

  def load
    Dir.children("./commands").each do |file|
      next if !file.ends_with? ".cr"
      begin
        require "./commands/#{file}"
        next if command.is_a?(Command)
        cmd = command.as(Command)
        @commands[cmd.name] = cmd
        puts "Loaded file #{file}"
      rescue ex
        puts "Failed loading file #{file}, skipping..."
      end
    end
  end
end
