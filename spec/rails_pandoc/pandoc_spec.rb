require 'spec_helper'

describe RailsPandoc::Pandoc do
  it "should respond to convert" do
    RailsPandoc::Pandoc.should respond_to(:convert)
  end

  it "should return converted markdown to html by default" do
    markdown = "* a\n* b"
    expected = "<ul>\n<li>a</li>\n<li>b</li>\n</ul>\n"
    RailsPandoc::Pandoc.convert(markdown).should == expected
  end

  it "should return error as result when unknown writer" do
    expected = "pandoc: spawn error\n"
    result = RailsPandoc::Pandoc.convert("* a\n* b", "--from=markdown --to=unknownwriter")
    result.should == expected
  end

  it "should sanitize html" do
    input = %Q|<a href="example.com"><script>alert('hello there');</script>here.</a>|
    expected = %Q|<a href=\"example.com\">\nalert('hello there');\n<p>here.</a></p>\n|
    RailsPandoc::Pandoc.sanitize(RailsPandoc::Pandoc.convert(input)).should == expected
  end

  it "should return error text if no valid pandoc executable is set" do
    expected = "Sorry, pandoc couldn't be found!"
    RailsPandoc::Config.executable="does_not_exist"
    RailsPandoc::Pandoc.convert("doesn't matter").should == expected
  end
end