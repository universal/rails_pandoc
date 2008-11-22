require 'test/unit'
require 'test_helper'
class PandocTest < Test::Unit::TestCase
  # Replace this with your real tests.
  def test_class_should_respond_to_convert
    assert_respond_to Pandoc, :convert
  end
  
  def test_should_return_converted_markdown_to_html_by_default
    markdown = "* a\n* b"
    expected = "<ul\n><li\n  >a</li\n  ><li\n  >b</li\n  ></ul\n>\n"
    assert_equal expected, Pandoc.convert(markdown)
  end
  
  def test_should_return_error_as_result_when_unknown_writer
    expected = "pandoc: Unknown writer: unknownwriter\n"
    result = Pandoc.convert("* a\n* b", "--from=markdown --to=unknownwriter")
    assert_equal expected, result
  end
  
  def test_should_sanitize_html
    input = %Q|<a href="example.com"><script>alert('hello there');</script>here.</a>|
    expected = %Q|<p\n><a href="example.com"><!-- unsafe HTML removed -->alert('hello there');<!-- unsafe HTML removed -->here.</a></p\n>\n|
    assert_equal expected, Pandoc.convert(input)
  end
  
  def test_should_have_class_attribute_for_executable
    assert_respond_to Pandoc, :executable
    assert_respond_to Pandoc, :executable=
  end
  
  def test_executable_should_be_pandoc_by_default
    assert_equal "pandoc", Pandoc.executable
  end

end
