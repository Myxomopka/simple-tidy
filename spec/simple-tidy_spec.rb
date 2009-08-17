require File.dirname(__FILE__) + '/spec_helper'

describe SimpleTidy do

=begin
remi@ninamori:~/projects/devfu/devfu.com:master $ echo "<html><title>hi</title>woot</html>" | tidy --tidy-mark false
line 1 column 1 - Warning: missing <!DOCTYPE> declaration
line 1 column 24 - Warning: plain text isn't allowed in <head> elements
line 1 column 7 - Info: <head> previously mentioned
line 1 column 24 - Warning: inserting implicit <body>
Info: Document content looks like HTML 3.2
3 warnings, 0 errors were found!

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 3.2//EN">
<html>
<head>
<title>hi</title>
</head>
<body>
woot
</body>
</html>

To learn more about HTML Tidy see http://tidy.sourceforge.net
Please fill bug reports and queries using the "tracker" on the Tidy web site.
Additionally, questions can be sent to html-tidy@w3.org
HTML and CSS specifications are available from http://www.w3.org/
Lobby your company to join W3C, see http://www.w3.org/Consortium
=end

  it 'should be able to easily tidy html (without any options)' do
    html = '<html>foo</html>'

    SimpleTidy.new.clean(html).should == 
      "<!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 3.2//EN\">\n" + 
      "<html>\n<head>\n<title></title>\n</head>\n<body>\nfoo\n</body>\n</html>"
  end

  it 'should have a shortcut to tidy html without creating a SimpleTidy instance' do
    html = '<html>foo</html>'

    SimpleTidy.clean(html).should == SimpleTidy.new.clean(html)
  end

  it 'should be able to pass options to shortcut'

  it 'should be able to get warnings' do
    html = '<html>foo</html>'
    tidy = SimpleTidy.new

    tidy.warnings.should be_empty
    tidy.clean html
    tidy.warnings.length.should == 4
    tidy.warnings.should include('line 1 column 1 - Warning: missing <!DOCTYPE> declaration')
    tidy.warnings.should include("line 1 column 7 - Warning: inserting missing 'title' element")
  end

  it 'should be able to get errors'

  it 'should be able to get diagnostics ... aka info? ... aka debug?'

  it 'should be able to set the indent option'

end
