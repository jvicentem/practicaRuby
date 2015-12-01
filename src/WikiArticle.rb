require_relative 'Article'

class WikiArticle < Article
  
  def initialize(id, title, sections, acronyms, last_updated)
    super(id, title, '--', sections, acronyms)
    @last_updated = last_updated
  end
  
  def self.create_empty_WikiArticle
    WikiArticle.new('','',[],[],0)
  end
  
  def self.list_of_lines_to_articles(list_of_lines)
    super(list_of_lines, WikiArticle.create_empty_WikiArticle())
  end
  
  def self.wikiArticle?(lines)
    return get_id(lines).starts_with?('WDOC')
  end
  
  def self.lines_to_article(lines)
    if wikiArticle?(lines) then
      WikiArticle.new(
        get_id(lines),
        get_title(lines),
        get_sections(lines),
        get_acronyms(lines),
        get_last_updated(lines)
      )
    else
      return nil
    end
  end
  
  def to_s
    super + "Last updated: #{self.last_updated}"
  end
  
  attr_reader :last_updated
  
  private
    def get_id(lines) 
      lines[0]
    end
    
    def get_last_updated(lines)
      lines[1]
    end    
    
    def get_title(lines)
      lines[2]
    end
    
    def get_sections(lines)
      sections = get_separated_content(lines)
      section_titles = []
      sections.find_all {|section| section_titles << section.scan(/^\d\.\s.+/)}
      return section_titles.flatten
    end
    
    def get_acronyms(lines)
      super(lines)
    end
end

# TEST
# art = WikiArticle.create_empty_WikiArticle
# lines = ["id","year","title","--","1. section title 1","section content 1","--","2. section title 2","section content 2","--"]
# puts art.get_id(lines);
# puts art.get_title(lines);
# puts art.get_last_updated(lines);
# puts art.get_sections(lines);
# puts art.get_acronyms(lines);
# puts art.to_s()
# puts WikiArticle.list_of_lines_to_articles([lines])