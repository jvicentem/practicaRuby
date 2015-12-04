require_relative 'IOUtils'
require_relative 'Article'

class ArticlesMap
  @@articles = IOUtils.new().get_articles()
  
  def self.articles
    @@articles
  end
  
  def self.sort_articles_by_year_only_title
    map1 = WikiArticle.sort_wikiArticles_by_year(self.articles.select { |art| art.is_a?(WikiArticle) })
    map2 = NormalArticle.sort_normalArticles_by_year(self.articles.select { |art| art.is_a?(NormalArticle) })
    
    map1.merge(map2){|key, oldval, newval| newval + oldval}
      
    map1.each_key() {|key| 
      articles_list = Article.sort_list_of_articles_by_title(map1[key])
      map1[key] = articles_list
    }
    
    return map1
  end
  
  def self.sort_acronyms_by_year
    map1 = WikiArticle.sort_wikiArticles_acronyms_by_year(self.articles.select { |art| art.is_a?(WikiArticle) })
    map2 = NormalArticle.sort_normalArticles_acronyms_by_year(self.articles.select { |art| art.is_a?(NormalArticle) })
    
    map1.merge(map2){|key, oldval, newval| newval + oldval}
  end
  
  def self.sort_articles_by_source
    NormalArticle.sort_normalArticles_by_source(self.articles.select { |art| art.is_a?(NormalArticle) })
  end
  
  def self.sort_articles_by_acronym
    Article.sort_articles_by_acronym(self.articles)
  end
  
  def self.sort_articles_by_acronym_only_title
    Article.sort_titles_by_acronym(self.articles)
  end
  
  def self.sort_articles_by_source_and_acronym
    hash_acronyms = Article.sort_articles_by_acronym(self.articles)
    
    hash_acronyms.each_key() {|key| 
        articles_list = hash_acronyms[key]
        hash_source = NormalArticle.sort_normalArticles_by_source_only_title(
                                                articles_list.select { |art| art.is_a?(NormalArticle) }
                                                )
        hash_acronyms[key] = hash_source
    }
  end

=begin  
  def self.sort_articles_by_cluster
  end
=end
  private
    def initialize 
    end
end

#TEST
#puts ArticlesMap.articles
#p ArticlesMap.sort_articles_by_year()
#p ArticlesMap.sort_articles_by_source()