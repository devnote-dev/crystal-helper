require "discordcr"

struct Command
  property name        : String
  property description : String
  property usage       : String
  property permissions : Int32
  setter run

  def initialize(@name, @description, @usage, @permissions, &run : -> Nil)
    @run = run
  end

  def exec(client : Discord::Client, ctx)
    @run.call client, ctx
  end
end
