=begin
Esta clase implementa los detalles concretos sobre cómo extraer
información de artículos que se encuentran en archivos de texto.
=end

class TextFileUtils
  
  def initialize (path)
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
    list_of_files = get_file_paths_from_directory
    list_of_lines = []
    list_of_files.each {|f| list_of_lines << read_file(f)}
    return list_of_lines
  end
  
  private
    def valid_path? (path)
      File.directory?(path)
    end
    
    def get_file_paths_from_directory
      Dir[self.folder_with_articles+'/*']
    end
  
    def read_file (file_path)
      lines = []
        
      File.open(file_path, "r") do |f|
        f.each_line do |line|
          lines << line
        end
      end
      
      return lines     
    end
end