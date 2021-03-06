require 'open3'

class SimpleTidy

  DEFAULT_OPTIONS = { :tidy_mark => false }

  OPTIONS_WITHOUT_VALUES = [ :indent ]

  SINGLE_DASH_OPTIONS = [ :indent ]

  def initialize options = nil
    @tidy_options = DEFAULT_OPTIONS.merge(options || {})
  end

  def warnings
    @warnings || []
  end

  def clean html
     @output, @warnings = get_output_and_warnings html
     @output
  end

  def self.clean html, options = nil
    SimpleTidy.new(options).clean html
  end

private

  def get_output_and_warnings html
    stdin, stdout, stderr = Open3.popen3 "tidy #{ tidy_options_text } #{ temp_file(html) }"
    output   = stdout.read.strip
    warnings = stderr.read.split("\n").select {|line| line =~ /line \d+ column \d+ - Warning:/ }
    return output, warnings
  end

  def tidy_options

    # check options for dependencies (some options require other options to be set)
    if @tidy_options.keys.include? :indent_spaces and ! @tidy_options[:indent] == true
      @tidy_options[:indent] = true
    end

    @tidy_options
  end

  def tidy_options_text
    tidy_options.map {|key, value| 
      option = dashes_for_option key
      option << key.to_s.gsub('_', '-')
      option << " #{ value.to_s.gsub('_', '-') }" unless OPTIONS_WITHOUT_VALUES.include?(key)
      option
    }.join(' ')
  end

  def dashes_for_option option
    SINGLE_DASH_OPTIONS.include?(option) ? '-' : '--'
  end

  def temp_file html
    filename = "/tmp/simple-tidy-#{ Time.now.strftime('%Y%m%d%H%M%S') }.html"
    File.open(filename, 'w'){|f| f << html }
    filename
  end

end
