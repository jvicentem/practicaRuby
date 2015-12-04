require_relative 'ArticlesMap'

class Functions
  def self.initialize_articlesMaps
    [] << ArticlesMap.sort_articles_by_acronym() << ArticlesMap.sort_articles_by_source() << ArticlesMap.sort_articles_by_year()
  end
  
  @@articlesMaps = Functions.initialize_articlesMaps()
    
  def self.articlesMaps
    @@articlesMaps
  end
  
  def self.get_sort_articles_by_acronym_hash_table
  end
  
  def self.get_sort_articles_by_source_hash_table
  end
  
  def self.get_sort_articles_by_year_hash_table
    self.articlesMaps()[2]
  end
  
  def self.articles_by_year(year)
    self.get_sort_articles_by_year_hash_table()[year]
  end
    
  private
    def initialize
    end
end

# TEST
#puts Functions.articles
#p StringUtils.has_any_of_these_characters_at_the_end?('(PCR).',['.',',',':',';'])
#p StringUtils.remove_last_char!('(PCR).')
#p Functions.articlesMaps
p Functions.articles_by_year("2015")