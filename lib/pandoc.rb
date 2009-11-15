class Pandoc
  cattr_accessor :executable, :valid_executable
  def self.executable=(executable)
    @@executable = executable
    unless executable.match(/\A[\w\.]+\Z/).nil?
      which = `which #{executable}`
      self.valid_executable= (which != "")
    else
      self.valid_executable= File.exists?(executable)
    end
  end
  self.executable= "pandoc" unless self.executable
  
  
  def self.convert(source, options= "--from=markdown --to=html")
    if self.valid_executable
      result = ""
      Open3.popen3("#{self.executable} #{options} --sanitize-html") do |input, output, error|
        input.puts source
        input.close
        result = error.read
        if result.blank?
          result = output.read
        end
      end
    else
      result = "Sorry, pandoc couldn't be found!"
    end
    result
  end
end
