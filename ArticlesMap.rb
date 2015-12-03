require_relative 'IOUtils'
require_relative 'Article'

class ArticlesMap
  @@articles = IOUtils.new().get_articles()
  
  def self.articles
    @@articles
  end
  
  def self.sort_articles_by_year
    map1 = WikiArticle.sort_wikiArticles_by_year(self.articles.select { |art| art.is_a?(WikiArticle) })
    map2 = NormalArticle.sort_normalArticles_by_year(self.articles.select { |art| art.is_a?(NormalArticle) })
    
    map1.merge(map2){|key, oldval, newval| newval + oldval}
  end
  
  def self.sort_articles_by_source
    NormalArticle.sort_normalArticles_by_source(self.articles.select { |art| art.is_a?(NormalArticle) })
  end
  
  def self.sort_articles_by_acronym
    Article.sort_articles_by_acronym(self.articles)
  end

=begin  
  def self.sort_articles_by_cluster
  end
=end
end

#TEST
#puts ArticlesMap.articles
#p ArticlesMap.sort_articles_by_year()
p ArticlesMap.sort_articles_by_source()