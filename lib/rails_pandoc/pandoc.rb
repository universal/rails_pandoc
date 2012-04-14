module RailsPandoc
  class Pandoc
    def self.convert(source, options= "--from=markdown --to=html")
      if Config.valid_executable
        result = ""
        begin
          cmd = "#{Config.executable} #{options} --mathjax"
          stdout, stderr = "", ""
          Open4.spawn cmd, 'stdin' => source, 'stdout' => stdout, 'stderr' => stderr, 'timeout' => 5
          result = stderr.blank? ? stdout : stderr
        rescue Open4::SpawnError
          result = "pandoc: spawn error\n"
        rescue Timeout::Error
          HoptoadNotifier.notify(ArgumentError.new("timed out with source =\n\n #{source}"))
          result = "Timed out<br/>We've been notified about this."
        end
      else
        result = "Sorry, pandoc couldn't be found!"
      end
      result
    end

    def self.sanitize(source)
      if Config.valid_sanitize
        result = ""
        ::Open3.popen3("#{Config.sanitize_executable}") do |input, output, error|
          input.puts source
          input.close
          result = output.read
        end
      else
        "Sorry, couldn't sanitize!"
      end
    end
  end
end