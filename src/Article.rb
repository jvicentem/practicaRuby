class Article

  def initialize(id, title, separator, sections, acronyms)
    @id = id
    @title = title 
    @separator = separator 
    @sections = sections
    @acronyms = acronyms
  end
  
  def self.list_of_lines_to_articles(list_of_lines,article_type)
    list_of_articles = []
    list_of_lines.each {|lines| list_of_articles << article_type.lines_to_article(lines)}
    return list_of_articles
  end
  
  def get_separated_content(lines)
    lines.drop(3).delete_if { |element| element == self.separator }
  end
  
  def get_acronyms(lines)
    # Por cada línea, busca acrónimos y si encuentra uno busco su 
    # significado llamando a la función de la clase Acronym get_meaning
    # pasándole como parámetro un array con las palabras desde la primera
    # hasta donde está el acrónimo, sin incluirle [0...acronym_position]
    []
  end
  
  def to_s
    return "ID: #{self.id} \nTitle: #{self.title} \nSections: #{self.sections} \nAcronyms: #{self.acronyms}\n"
  end
  
  attr_reader :id, :title, :separator, :sections, :acronyms
end

# TEST

# art = Article.new("","","--",[],[])
# puts art.get_separated_content(["a","a","a","--","b","c","--","d","e"])