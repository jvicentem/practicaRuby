require_relative 'IOUtils'

class Functions
  @@articles = IOUtils.new().get_articles()
  
  def self.articles
    @@articles
  end
end

# TEST
puts Functions.articles
#p StringUtils.has_any_of_these_characters_at_the_end?('(PCR).',['.',',',':',';'])
#p StringUtils.remove_last_char!('(PCR).')