class NightWriter
  attr_reader :message, :braille
  def initialize(args)
    @message = File.open(args[0], "r")
    @braille = File.open(args[1], "w")
  end

  def readfile
  nothing = @message.read
  @braille.write.upcase
  @message.close
  @braille.close
  end
end

if $PROGRAM_NAME == __FILE__
  NightWriter.new(ARGV).readfile
end
