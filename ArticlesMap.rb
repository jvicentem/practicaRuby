require_relative 'Article'

class ArticlesMap
  @@articles = nil
  
  def self.init(articles_list)
    @@articles = articles_list
  end
  
  def self.articles
    @@articles
  end
  
  def self.sort_articles_by_year_only_title
    map1 = WikiArticle.sort_wikiArticles_by_year_only_title(self.articles.select { |art| art.is_a?(WikiArticle) })
    map2 = NormalArticle.sort_normalArticles_by_year_only_title(self.articles.select { |art| art.is_a?(NormalArticle) })
    
    merged = map1.merge(map2){|key, oldval, newval| newval + oldval}
    
    return merged
  end
  
  def self.sort_acronyms_by_year
    map1 = WikiArticle.sort_wikiArticles_acronyms_by_year(self.articles.select { |art| art.is_a?(WikiArticle) })
    map2 = NormalArticle.sort_normalArticles_acronyms_by_year(self.articles.select { |art| art.is_a?(NormalArticle) })
    
    map1.merge(map2){|key, oldval, newval| newval + oldval}
  end
  
  def self.sort_articles_by_source
    normal_articles = ArticlesMap.articles.select { |art| art.is_a?(NormalArticle) }
    table = NormalArticle.sort_normalArticles_by_source(normal_articles)
    return table
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
  
  def self.sort_acronyms_by_id()
    Article.sort_acronyms_by_id(self.articles)
  end
  
  def self.sort_articles_without_acronyms(hash_table)
    Article.get_id_and_title_of_articles_without_acronyms(hash_table)
  end
  
  private
    def initialize 
    end
end

#TEST
#puts ArticlesMap.articles
#p ArticlesMap.sort_articles_by_year()