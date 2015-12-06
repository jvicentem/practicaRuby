require_relative 'ArticlesMap'

class Functions
  def self.initialize_articlesMaps
    hash_tables_list = []
    hash_tables_list << ArticlesMap.sort_articles_by_acronym() << 
      ArticlesMap.sort_articles_by_source() << 
      ArticlesMap.sort_articles_by_year_only_title() << 
      ArticlesMap.sort_articles_by_acronym_only_title() <<
      ArticlesMap.sort_articles_by_source_and_acronym() <<
      ArticlesMap.sort_acronyms_by_year() <<
      ArticlesMap.sort_acronyms_by_id() <<
      ArticlesMap.sort_articles_without_acronyms(hash_tables_list[0]) <<
      ArticlesMap.sort_articles_by_cluster()
  end
  
  @@articlesMaps = Functions.initialize_articlesMaps()
    
  def self.articlesMaps
    @@articlesMaps
  end
  
  def self.get_sort_articles_by_acronym_hash_table
    self.articlesMaps()[0]
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
  
  def self.get_sort_acronyms_by_year_hash_table
    self.articlesMaps()[5]
  end
  
  def self.get_sort_acronyms_by_id_hash_table
    self.articlesMaps()[6]
  end
  
  def self.get_sort_articles_without_acronyms_hash_table
    self.articlesMaps()[7]
  end
  
  def self.get_sort_articles_by_cluster_hash_table
    self.articlesMaps()[8]
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
    self.get_sort_acronyms_by_year_hash_table[year].flatten!
  end
  
  #6
  def self.acronyms_by_id(id)
    self.get_sort_acronyms_by_id_hash_table()
  end
  
  #7
  def self.articles_without_acronyms()
    self.get_sort_articles_without_acronyms_hash_table
  end
  
  #8
  def self.articles_by_acronym(acronym)
    self.get_sort_articles_by_acronym_hash_table()[acronym].each {|element| element.to_s}
  end
  
  #9
  def self.group_articles
    self.get_sort_articles_by_cluster_hash_table
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
#p Functions.acronyms_by_id("4407188")
#p Functions.get_sort_acronyms_by_id_hash_table()
#p Functions.articles_without_acronyms()
#puts Functions.articles_by_acronym("OXR1")
#p Functions.group_articles()