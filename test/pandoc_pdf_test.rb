require 'test/unit'
require File.dirname(__FILE__) + '/test_helper.rb'

class PandocPDFTest < Test::Unit::TestCase
  def test_class_should_respond_to_to_pdf
    assert_respond_to PandocPDF, :to_pdf
  end
  
  def test_to_pdf_should_have_2_arguments
    assert_equal 2, PandocPDF.method(:to_pdf).arity, "should take two arguments"
  end
    
  def test_to_pdf_should_return_success_status_and_output
    status, output = PandocPDF.to_pdf(nil, nil)
    assert (status.class == TrueClass || status.class == FalseClass), "status is not a boolean"
    assert_kind_of String, output, "output is not a string"
  end
  
  def test_to_pdf_should_return_false_if_no_source_supplied
    status, output = PandocPDF.to_pdf(nil, nil)
    assert !status, "should not be successful without source"
  end
  
  def test_to_pdf_should_return_error_msg_if_no_source_supplied
    status, output = PandocPDF.to_pdf(nil, nil)
    assert_equal "expected non nil source", output, "no source supplied"
  end

  def test_to_pdf_should_return_false_if_no_target_supplied
    status, output = PandocPDF.to_pdf("PandocPDF", nil)
    assert !status, "no target supplied"
  end
  
  def test_to_pdf_should_return_error_msg_if_no_target_supplied
    status, output = PandocPDF.to_pdf("PandocPDF", nil)
    assert_equal "expected non nil target", output, "no target supplied"
  end
  
  def test_to_pdf_should_return_true_with_valid_source_and_target
    with_tmpdir do
      status, output = PandocPDF.to_pdf(valid_source, valid_target)
      assert status
      assert File.exists?(valid_target)
    end
  end

  def test_to_pdf_should_return_false_with_invalid_source
    with_tmpdir do
      status, output = PandocPDF.to_pdf(invalid_source, valid_target)
      assert !status
      assert output.size > 0
    end
  end

  def test_to_pdf_should_have_error_msg_in_output_with_invalid_source
    with_tmpdir do
      status, output = PandocPDF.to_pdf(invalid_source, valid_target)
      assert output.include? "Fatal error occurred, no output PDF file produced!"
    end
  end

  def test_to_pdf_should_not_create_target_file_with_invalid_source
    with_tmpdir do
      status, output = PandocPDF.to_pdf(invalid_source, valid_target)
      assert !File.exists?(valid_target)
    end
  end
  
  def test_to_pdf_should_not_leave_any_tmp_files_behind
    with_tmpdir do
      PandocPDF.to_pdf(invalid_source, valid_target)
      assert Dir.glob("tmp/*").size == 0, "temporary directory not empty"
    end
  end

  
  private
  def with_tmpdir
    setup_tmp
    yield
    cleanup_tmp
  end
  
  def setup_tmp
    File.makedirs "tmp"
  end
  
  def cleanup_tmp
    FileUtils.rm_f(Dir.glob("tmp/*"))
    FileUtils.rmdir "tmp"
  end
  
  def valid_source
    <<-eos
    \\documentclass[12pt]{scrartcl}
    \\begin{document}

    bla

    \\end{document}
    eos
  end
  
  def invalid_source
    <<-eos
    \\documentclass[12pt]{scrartcl}
    \\begin{document}

    bla
    eos
  end
  
  def valid_target
    "tmp/test.pdf"
  end
end