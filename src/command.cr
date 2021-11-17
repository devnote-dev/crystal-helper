struct Command
  property name        : String
  property description : String
  property usage       : String
  property permissions : Int32
  setter run

  def initialize(@name, @description, @usage, @permissions, &run)
    @run = run
  end

  def exec(*ctx)
    @run.call *ctx
  end
end
