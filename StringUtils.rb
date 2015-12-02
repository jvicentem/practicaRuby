require_relative 'WikiArticle'
require_relative 'NormalArticle'

class StringUtils
  
  def self.remove_parenthesis(string)
    string.tr('()', '')
  end
  
  def self.remove_character(string,char)
    string.tr_s(char, '') 
  end
  
  def self.list_of_lines_to_articles(list_of_lines)
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
  
  def self.remove_last_char!(string)
    string.chop!
  end
  
  
  def self.has_any_of_these_characters_at_the_end?(word,char_list)
    last_char = word[-1] 
    char_list.include?(last_char)
  end

  private
    def initialize 
    end
end

#TEST
