require_relative 'IOUtils'
require_relative 'Article'

class ArticlesMap
  @@articles = IOUtils.new().get_articles()
  
  def self.articles
    @@articles
  end
  
  def self.sort_articles_by_year
    
  end
  
  def self.sort_articles_by_source
  end
  
  def self.sort_articles_by_acronym
  end
  
  def self.sort_articles_by_has_acronym_or_not
  end
  
  def self.sort_articles_by_cluster
  end
end

#TEST
puts ArticlesMap.articles