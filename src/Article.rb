class Article

  def initialize(id, title, separator, sections, acronyms)
    @id = id
    @title = title 
    @separator = separator 
    @sections = sections
    @acronyms = acronyms
  end
  
  # http://stackoverflow.com/questions/2393697/look-up-all-descendants-of-a-class-in-ruby
  def self.descendants
    ObjectSpace.each_object(Class).select { |klass| klass < self }
  end
  
  def self.list_of_lines_to_articles(list_of_lines)
    list_of_articles = []
    descendants_classes = Article.descendants #Busco las clases hijas de esta
    descendants_classes.each {|child_class| #Paso las líneas a artículos invocando al método lines_to_article de cada clase
      list_of_lines.each {|lines| list_of_articles << child_class.constantize.lines_to_article(lines)}
    }
    return list_of_articles.compact #Como hay distintos tipos de artículos, los que no coincidan devolveran nil. Con .compact se eliminan los valores nil
  end
  
  def get_separated_content(lines)
    lines.drop(3).delete_if {|element| element == self.separator}
  end
  
  def get_acronyms(lines)
    lines.each do |line|
      words_list = line.split(/\s/)
      words_list.each_with_index {|word, index|
                                    acronyms << Acronym.get_meaning(word,words_list[0...index]) if Acronym.acronym?(word)
                                 }
    end
    
    return acronyms
  end
  
  def to_s
    return "ID: #{self.id} \nTitle: #{self.title} \nSections: #{self.sections} \nAcronyms: #{self.acronyms}\n"
  end
  
  attr_reader :id, :title, :separator, :sections, :acronyms
end

# TEST

# art = Article.new("","","--",[],[])
# puts art.get_separated_content(["a","a","a","--","b","c","--","d","e"])