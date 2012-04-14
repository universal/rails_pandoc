module RailsPandoc
  class Config
    cattr_accessor :executable, :valid_executable, :sanitize_executable, :valid_sanitize

    def self.executable=(executable)
      @@executable = executable
      unless executable.match(/\A[\w\.]+\Z/).nil?
        which = `which #{executable}`
        @@valid_executable = (which != "")
      else
        @@valid_executable = File.exists?(executable)
      end
    end

    def self.sanitize_executable=(sanitize_executable)
      @@sanitize_executable = sanitize_executable
      unless sanitize_executable.match(/\A[\w\.]+\Z/).nil?
        which = `which #{sanitize_executable}`
        @@valid_sanitize = (which != "")
      else
        @@valid_sanitize = File.exists?(sanitize_executable)
      end
    end
  end

  Config.executable = "pandoc"
  Config.sanitize_executable = "sanitize"
end