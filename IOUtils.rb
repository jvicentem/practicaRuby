=begin
Esta clase va a ser con la cual otras clases se van a comunicar 
para extraer artículos almacenados en medios externos.

La idea es que si se cambia el medio externo (por ejemplo, los
artículos dejan de estar en archivos de texto y pasan a estar en
una base de datos) sea el método de esta clase y el atributo 
external_source los que se modifiquen y así otras clases estén 
aisladas de los detalles concretos de extracción de información 
de artículos en medios externos.
=end
require_relative 'WikiArticle'
require_relative 'NormalArticle'
require_relative 'TextFileUtils'

class IOUtils
  def initialize
    @external_source = TextFileUtils.new("./docsUTF8prueba")
  end
  
  def get_articles ()
    list_of_lines_to_articles(read_files)
  end
  
  attr_reader :external_source
  
  private
    def read_files
      self.external_source.read_files
    end
    
    def list_of_lines_to_articles(list_of_lines)
      list_of_articles = []
=begin
      descendants_classes = Article.descendants #Busco las clases hijas de esta
      puts 'Prueba 3'
      descendants_classes.each {|child_class| #Paso las líneas a artículos invocando al método lines_to_article de cada clase
        puts 'Prueba 4'
        list_of_lines.each {|lines| list_of_articles << (Object.const_get child_class).classify.lines_to_article(lines)}
      }
=end
      descendants_classes = [] << WikiArticle.create_empty_WikiArticle() << NormalArticle.create_empty_normalArticle() #Busco las clases hijas de esta
      descendants_classes.each {|child_class| #Paso las líneas a artículos invocando al método lines_to_article de cada clase
        list_of_lines.each {|lines| list_of_articles << child_class.lines_to_article(lines)}
      }
      return list_of_articles.compact! #Como hay distintos tipos de artículos, los que no coincidan devolveran nil. Con .compact se eliminan los valores nil
    end
  
end

#TEST
#puts IOUtils.new().read_files()