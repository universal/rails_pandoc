require 'spec_helper'

describe RailsPandoc::PDFWriter do
  def with_tmpdir
    FileUtils.makedirs "tmp"
    yield
    FileUtils.rm_f(Dir.glob("tmp/*"))
    FileUtils.rmdir "tmp"
  end

  let(:valid_source) {
    <<-eos
    \\documentclass[12pt]{scrartcl}
    \\begin{document}

    bla

    \\end{document}
    eos
  }
  let(:invalid_source) {
    <<-eos
    \\documentclass[12pt]{scrartcl}
    \\begin{document}

    bla
    eos
  }
  let(:valid_target) {"tmp/test.pdf"}

  describe "to_pdf" do
    it "should return status and message" do |variable|
      status, message = RailsPandoc::PDFWriter.to_pdf(nil, nil)
      status.should_not be_nil
      message.should_not be_nil
    end
  end

  it "should return false if no sourcesupplied" do
    status, output = RailsPandoc::PDFWriter.to_pdf(nil, nil)
    status.should be_false
  end

  it "should return error msg if no source supplied" do
    status, output = RailsPandoc::PDFWriter.to_pdf(nil, nil)
    output.should == "expected non nil source"
  end

  it "should return false if no target supplied" do
    status, output = RailsPandoc::PDFWriter.to_pdf("RailsPandoc::PDFWriter", nil)
    status.should be_false
  end

  it "should return error msg if no target supplied" do
    status, output = RailsPandoc::PDFWriter.to_pdf("RailsPandoc::PDFWriter", nil)
    output.should == "expected non nil target"
  end

  it "should return true with valid source and target" do
    with_tmpdir do
      status, output = RailsPandoc::PDFWriter.to_pdf(valid_source, valid_target)
      status.should be_true
      File.exists?(valid_target).should be_true
    end
  end

  it "should return false with invalid source" do
    with_tmpdir do
      status, output = RailsPandoc::PDFWriter.to_pdf(invalid_source, valid_target)
      status.should be_false
      output.size.should > 0
    end
  end

  it "should have error msg in output with invalid source" do
    with_tmpdir do
      status, output = RailsPandoc::PDFWriter.to_pdf(invalid_source, valid_target)
      output.should include("Fatal error occurred, no output PDF file produced!")
    end
  end

  it "should not create target file with invalid source" do
    with_tmpdir do
      status, output = RailsPandoc::PDFWriter.to_pdf(invalid_source, valid_target)
      File.exists?(valid_target).should be_false
    end
  end

  it "should not leave any tmp files behind" do
    with_tmpdir do
      RailsPandoc::PDFWriter.to_pdf(invalid_source, valid_target)
      Dir.glob("tmp/*").size.should == 0
    end
  end
end