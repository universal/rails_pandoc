require File.dirname(__FILE__) + '/test_helper.rb'

class PandocHelperTest < ActionView::TestCase
  tests PandocHelper
  def test_action_view_base_should_respond_to_pandoc
    assert_respond_to ActionView::Base.new, :pandoc
  end
  
  def test_pandoc_should_generate_html_from_markdown_by_default
    markdown = "* a\n* b"
    expected = "<ul\n><li\n  >a</li\n  ><li\n  >b</li\n  ></ul\n>\n"
    assert_equal expected, pandoc(markdown)
  end
  
  def test_pandoc_should_generate_latex_from_markdown_if_specified
    markdown = "* a\n* b"
    expected = "\\begin{itemize}\n\\item\n  a\n\\item\n  b\n\\end{itemize}\n"
    assert_equal expected, pandoc(markdown, "latex")
  end
  
  def test_pandoc_to_latex_should_generate_latex_from_markdown
    markdown = "* a\n* b"
    expected = "\\begin{itemize}\n\\item\n  a\n\\item\n  b\n\\end{itemize}\n"
    assert_equal expected, pandoc_to_latex(markdown)
  end

  def test_pandoc_to_html_should_generate_html_from_markdown
    markdown = "* a\n* b"
    expected = "<ul\n><li\n  >a</li\n  ><li\n  >b</li\n  ></ul\n>\n"
    assert_equal expected, pandoc_to_html(markdown)
  end
  
  def test_short_aliases
    markdown = "* a\n* b"
    assert_equal pan2l(markdown), pandoc_to_latex(markdown)
    assert_equal pan2h(markdown), pandoc_to_html(markdown)
  end
  
end
