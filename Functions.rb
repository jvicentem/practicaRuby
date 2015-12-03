require_relative 'ArticlesMap'

class Functions
  def self.initialize_articlesMaps
    [] << ArticlesMap.sort_articles_by_acronym() << ArticlesMap.sort_articles_by_source() << ArticlesMap.sort_articles_by_year()
  end
  
  @@articlesMaps = Functions.initialize_articlesMaps()
    
  def self.articlesMaps
    @@articlesMaps
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