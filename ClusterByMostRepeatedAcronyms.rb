require_relative 'Article'

class ClusterByMostRepeatedAcronyms
  
  def initialize(articles)
    @articles_hash_table = Article.sort_articles_by_most_repeated_acronyms(articles)
  end
  
  attr_reader :articles_hash_table
  
  def sort_articles_by_most_repeated_acronyms_only_title_and_id()
    return Article.sort_articles_by_most_repeated_acronyms_only_title_and_id(self.articles_hash_table)
  end
  
  def number_of_clusters
    self.articles_hash_table.keys.length
  end
  
  def average_number_of_NormalArticles
    number_of_NormalArticles = 0
    self.articles_hash_table.each_key { |key|
      self.articles_hash_table[key].each {|art| 
        number_of_NormalArticles = number_of_NormalArticles + 1 if art.is_a?(NormalArticle)  
      }
    }
    return (number_of_NormalArticles.to_f / number_of_clusters.to_f)
  end
  
  def average_number_of_WikiArticles
    number_of_WikiArticles = 0
    self.articles_hash_table.each_key { |key|
      self.articles_hash_table[key].each {|art|
        number_of_WikiArticles = number_of_WikiArticles + 1 if art.is_a?(WikiArticle)  
      }
    }
    return (number_of_WikiArticles.to_f / number_of_clusters.to_f)
  end
  
  def number_of_clusters_with_articles_written_in_the_same_year
    number = 0
    
    self.articles_hash_table.each_key { |key|
      normal = NormalArticle.year_of_articles(self.articles_hash_table[key])
      wiki = WikiArticle.year_of_articles(self.articles_hash_table[key])
      articles_group = (wiki+normal)
      number = number + 1 if articles_group.all? {|year| year == articles_group[0] }
    }   
    
    return number
  end
  
  def number_of_clusters_with_articles_written_in_the_different_year
    number_of_clusters - number_of_clusters_with_articles_written_in_the_same_year
  end
  
  def number_of_clusters_with_one_article
    number = 0
    self.articles_hash_table.each_key {|key| number = number + 1 if self.articles_hash_table[key].length == 1}
    return number
  end
  
end
