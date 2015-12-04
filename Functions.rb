require_relative 'ArticlesMap'
require_relative 'Acronym'

class Functions
  def self.initialize_articlesMaps
    [] << ArticlesMap.sort_articles_by_acronym() << 
      ArticlesMap.sort_articles_by_source() << 
      ArticlesMap.sort_articles_by_year_only_title() << 
      ArticlesMap.sort_articles_by_acronym_only_title() <<
      ArticlesMap.sort_articles_by_source_and_acronym() <<
      ArticlesMap.sort_acronyms_by_year()
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
  
  def self.get_sort_articles_by_source_and_acronym_hash_table
    self.articlesMaps()[4]
  end
  
  def self.get_sort_acronyms_by_year
    self.articlesMaps()[5]
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
  
  #4
  def self.articles_by_source_and_acronym(source,acronym)
    self.get_sort_articles_by_source_and_acronym_hash_table()[acronym].values.flatten!
  end
  
  #5
  def self.acronyms_by_year(year)
    self.get_sort_acronyms_by_year[year].flatten!
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
#p Functions.get_sort_articles_by_source_and_acronym_hash_table()
#p Functions.articles_by_source_and_acronym("Brain","OXR1")
#p Functions.acronyms_by_year("2015")