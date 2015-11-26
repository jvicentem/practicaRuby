require 'Article'

class NormalArticle < Article
  def initialize (id, title, year, separator, sections, acronyms, source, abstract)
    super(id, title, year, separator, sections, acronyms)
    @source, @abstract = source, abstract
  end
  
  def list_of_lines_to_articles (list_of_lines)
  end
  
  private
    def lines_to_article (lines)
      
    end
end