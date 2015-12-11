=begin
Esta clase implementa los detalles concretos sobre cómo extraer
información de artículos que se encuentran en archivos de texto.
=end

class TextFileUtils
  
  def initialize(path)
    if valid_path?(path) then
      @folder_with_articles = path
    else
      @folder_with_articles = ""
    end
  end
  
  attr_reader :folder_with_articles
  
=begin
read_files devuelve una lista en la que cada posición hay una
lista con las líneas de texto de cada artículo.
=end
  
  def read_files
    begin
      list_of_files = get_file_paths_from_directory
    rescue IOError => e
      raise e
    end
    list_of_lines = []
    list_of_files.each {|f| list_of_lines << read_file(f)}
    return list_of_lines.reject(&:nil?)
  end
  
  private
    def valid_path?(path)
      File.directory?(path)
    end
    
    def get_file_paths_from_directory
      paths = Dir[self.folder_with_articles+'/*']
      
      if paths == Dir['/*'] then
       raise IOError.new('No se han encontrado artículos. La lista de artículos estará vacía y es posible que se produzcan errores de ejecución.')
      else
       return paths
      end
    end
  
    def read_file(file_path)
      lines = []
        
      File.open(file_path, "r") do |f|
        f.each_line do |line|
          lines << line.chomp!
        end
      end
      
      return lines.reject(&:nil?)    
    end
end