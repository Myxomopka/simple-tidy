require File.dirname(__FILE__) + '/spec_helper'

describe SimpleTidy do

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

  # it 'should be able to get errors'
  # it 'should be able to get diagnostics ... aka info? ... aka debug?'

  it 'should be able to set the indent option' do
    html = '<html>foo</html>'

    SimpleTidy.new( :indent_spaces => 2 ).clean(html).should == 
      "<!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 3.2//EN\">\n\n" + 
      "<html>\n<head>\n  <title></title>\n</head>\n\n<body>\n  foo\n</body>\n</html>"

    SimpleTidy.clean( html, :indent_spaces => 2 ).should == SimpleTidy.new( :indent_spaces => 2 ).clean(html)
  end

end
