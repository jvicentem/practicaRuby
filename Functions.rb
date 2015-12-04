require_relative 'ArticlesMap'
require_relative 'Acronym'

class Functions
  def self.initialize_articlesMaps
    [] << ArticlesMap.sort_articles_by_acronym() << ArticlesMap.sort_articles_by_source() << ArticlesMap.sort_articles_by_year() << ArticlesMap.sort_articles_by_acronym_only_title()
  end
  
  @@articlesMaps = Functions.initialize_articlesMaps()
    
  def self.articlesMaps
    @@articlesMaps
  end
  
  def self.get_sort_articles_by_acronym_hash_table
  end
  
  def self.get_sort_articles_by_source_hash_table
    self.articlesMaps()[1]
  end
  
  def self.get_sort_articles_by_year_hash_table
    self.articlesMaps()[2]
  end
  

  def self.get_sort_articles_by_acronym_only_title_hash_table
    self.articlesMaps()[3]
  end
  
  #1
  def self.articles_by_year(year)
    self.get_sort_articles_by_year_hash_table()[year]
  end
  
  #2
  def self.sources
    self.get_sort_articles_by_source_hash_table().keys
  end
  
  #3
  def self.articles_by_acronym(acronym)
    self.get_sort_articles_by_acronym_only_title_hash_table()[acronym]
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
#p Functions.articles_by_year("2015")
#p Functions.sources()
#p Functions.articles_by_acronym("OXR1")