class PandocPDF

  def self.to_pdf(source, target)
    return [false, "expected non nil source"] if source.nil?
    return [false, "expected non nil target"] if target.nil?
    temp_file = write_to_temp(source)
    output = `pdflatex -file-line-error -interaction nonstopmode -output-directory tmp #{temp_file.path}`
    ret_code = $?
    if(ret_code == 0)
      move_file("#{temp_file.path}.pdf", target)
    end
    cleanup(temp_file.path)
    [ret_code == 0, output]
  end
  
  private
  def self.write_to_temp(source)
    temp_file = Tempfile.new('tex_', "tmp")  
    temp_file.puts source
    temp_file.flush
    temp_file.close
    temp_file
  end
  
  def self.move_file(source, target)
    if File.exists? source
      File.delete(target) if File.exists? target
      path = File.dirname(target)
      File.makedirs(path)
      File.move(source, target)
    end
  end

  def self.cleanup(temp_file)
    FileUtils.rm_f(Dir.glob(temp_file+"*"))
  end

end