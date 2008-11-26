module PandocHelper
  protected
  def pandoc(source, output_format="html", input_format="markdown")
    Pandoc.convert(source, "--from=#{input_format} --to=#{output_format}")
  end
  
  def pandoc_to_html(source, input_format="markdown")
    pandoc(source, "html", input_format)
  end
  
  def pandoc_to_latex(source, input_format="markdown")
    pandoc(source, "latex", input_format).gsub(/includegraphics\{(https{0,1}:\/\/.*)\}/i, 'href{\1}{REPLACED IMAGE}')
  end
  
  alias_method :pan2h, :pandoc_to_html
  alias_method :pan2l, :pandoc_to_latex
end
