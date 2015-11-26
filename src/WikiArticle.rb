require 'Article'

class WikiArticle < Article
  def initialize (id, title, year, separator, sections, acronyms, last_updated)
    super(id, title, year, separator, sections, acronyms)
    @last_updated = last_updated
  end
  
  def list_of_lines_to_articles (list_of_lines)
  end
  
  private
    def lines_to_article (lines)
      
    end
end