SimpleTidy
==========

I've had a lot of trouble with the http://rubyforge.org/projects/tidy/ project (which uses libtidy-ruby), 
getting segfaults and whatnot.  So ... I decided to make super simple wrapper around the **tidy** 
command line app (instead of the C library).

Installation
------------

    $ sudo gem install devfu-simple-tidy --source http://gems.github.com

Usage
-----

    require 'simple-tidy'
  
    >> puts SimpleTidy.clean '<html>foo</html>', :indent_spaces => 2
    <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 3.2//EN">
    
    <html>
    <head>
      <title></title>
    </head>
    
    <body>
      foo
    </body>
    </html>
    => nil

Or, you can make instances of SimpleTidy for lower-level usage (eg. to get warnings)

    >> tidy = SimpleTidy.new :indent_spaces => 2
    => #<SimpleTidy:0x7fb5e56a70f0 @tidy_options={:indent_spaces=>2, :tidy_mark=>false}
  
    >> tidy.clean '<html>foo</html>'
    => "<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 3.2//EN">\n\n<html>\n<head>\n  <title></title>\n</head>\n\n<body>\n  foo\n</body>\n</html>"
  
    >> tidy.warnings
    => ["line 1 column 1 - Warning: missing <!DOCTYPE> declaration", "line 1 column 7 - Warning: plain text isn't allowed in <head> elements", "line 1 column 7 - Warning: inserting implicit <body>", "line 1 column 7 - Warning: inserting missing 'title' element"]

Configuration Options
---------------------

For documentation on the options: `man tidy`.  See the **DETAILED CONFIGURATION OPTIONS** section.  All of these options should be supported.
