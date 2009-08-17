require 'open3'

class SimpleTidy

  def initialize
  end

  def warnings
    @warnings || []
  end

  def clean html
     stdin, stdout, stderr = Open3.popen3 "echo '#{ html }' | tidy --tidy-mark false"
     @warnings = stderr.read.split("\n").select {|line| line =~ /line \d+ column \d+ - Warning:/ }
     stdout.read.strip
  end

  def self.clean html
    SimpleTidy.new.clean html
  end

end
