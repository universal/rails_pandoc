class Pandoc
  cattr_accessor :executable, :valid_executable, :sanitize_executable, :valid_sanitize
  
  def self.executable=(executable)
    @@executable = executable
    unless executable.match(/\A[\w\.]+\Z/).nil?
      which = `which #{executable}`
      self.valid_executable= (which != "")
    else
      self.valid_executable= File.exists?(executable)
    end
  end
  
  def self.sanitize_executable=(sanitize_executable)
    @@sanitize_executable = sanitize_executable
    unless sanitize_executable.match(/\A[\w\.]+\Z/).nil?
      which = `which #{sanitize_executable}`
      self.valid_sanitize= (which != "")
    else
      self.valid_sanitize= File.exists?(sanitize_executable)
    end
  end
  
  self.executable= "pandoc" unless self.executable
  self.sanitize_executable= "sanitize" unless self.sanitize_executable
  
  def self.convert(source, options= "--from=markdown --to=html")
    self.convert4(source, options)
  end
  
  def self.sanitize(source)
    if self.valid_sanitize
      result = ""
      Open3.popen3("#{self.sanitize_executable}") do |input, output, error|
        input.puts source
        input.close
        result = output.read
      end
    else
      "Sorry, couldn't sanitize!"
    end
  end
  
  def self.convert4(source, options= "--from=markdown --to=html")
    if self.valid_executable
      result = ""
      begin
        cmd = "#{self.executable} #{options} --mathjax"
        stdout, stderr = "", ""
        Open4.spawn cmd, 'stdin' => source, 'stdout' => stdout, 'stderr' => stderr, 'timeout' => 5
        result = stderr.blank? ? stdout : stderr
      rescue Timeout::Error
        HoptoadNotifier.notify(ArgumentError.new("timed out with source =\n\n #{source}"))
        result = "Timed out<br/>We've been notified about this."
      end
    else
      result = "Sorry, pandoc couldn't be found!"
    end
    result
    
  end
end
