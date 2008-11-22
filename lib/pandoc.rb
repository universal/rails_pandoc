require 'open3'

class Pandoc
  cattr_accessor :executable
  self.executable= "pandoc" unless self.executable
  
  def self.convert(source, options= "--from=markdown --to=html")
    result = ""
    Open3.popen3("#{self.executable} #{options} --sanitize-html") do |input, output, error|
      input.puts source
      input.close
      result = error.read
      if result.blank?
        result = output.read
      end
    end
    result
  end
end
