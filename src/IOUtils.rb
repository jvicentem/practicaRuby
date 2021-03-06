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
    @external_source = TextFileUtils.new('./docsUTF8')
  end
  
  attr_reader :external_source
  
  def get_articles ()
     return list_of_lines_to_articles(read_files)
  end
  
  private
    def read_files
      begin
        self.external_source.read_files
      rescue IOError => e
        raise e
      end
    end
    
    def list_of_lines_to_articles(list_of_lines)
      list_of_articles = []   
      list_of_lines.each {|lines| 
        if NormalArticle.normalArticle?(lines) then
          list_of_articles << NormalArticle.create_empty_normalArticle().lines_to_article(lines)
        elsif WikiArticle.wikiArticle?(lines)
          list_of_articles << WikiArticle.create_empty_WikiArticle().lines_to_article(lines)
        end
        }
      return list_of_articles
    end
  
end