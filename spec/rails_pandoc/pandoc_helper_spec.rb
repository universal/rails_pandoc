require 'spec_helper'

describe RailsPandoc::PandocHelper do
  class Helper
    include RailsPandoc::PandocHelper
  end

  let(:markdown) {"* a\n* b"}
  let(:helper) {Helper.new}

  it "should call convert" do
    RailsPandoc::Pandoc.should_receive(:convert).with(markdown, "--from=markdown --to=html").and_return("")
    helper.send(:pandoc, markdown)
  end

  it "should sanitize for html" do
    RailsPandoc::Pandoc.should_receive(:sanitize)
    helper.send(:pandoc, markdown)
  end

  it "should call with latex format set if specified" do
    RailsPandoc::Pandoc.should_receive(:convert).with(markdown, "--from=markdown --to=latex").and_return("")
    helper.send(:pandoc, markdown, "latex")
  end

  it "sets format to latex for pandoc_to_latex" do
    helper.should_receive(:pandoc).with(markdown, "latex", "markdown").and_return("something")
    helper.send(:pandoc_to_latex, markdown)
  end

  it "sets format to html for pandoc_to_html" do
    helper.should_receive(:pandoc).with(markdown, "html", "markdown")
    helper.send(:pandoc_to_html, markdown)
  end

  it "calls long version for short aliases" do
    helper.should_receive(:pandoc).with(markdown, "latex", "markdown").and_return("something")
    helper.send(:pan2l, markdown)
    helper.should_receive(:pandoc).with(markdown, "html", "markdown").and_return("something")
    helper.send(:pan2h, markdown)
  end

  it "replaces external images with an url when using pandoc_to_latex" do
    image = "![Example](http://www.example.com/example.png)"
    helper.send(:pan2l, image).should == "\\begin{figure}[htbp]\n\\centering\n\\href{http://www.example.com/example.png}{REPLACED IMAGE}\n\\caption{Example}\n\\end{figure}\n\n"
  end
end