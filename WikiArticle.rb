require_relative 'Article'

class WikiArticle < Article
  
  def initialize(id, title, sections, acronyms, last_updated, introduction)
    super(id, title, '--', sections, acronyms)
    @last_updated,@introduction = last_updated, introduction
  end
  
  def self.create_empty_WikiArticle
    WikiArticle.new('','',[],[],0,[])
  end
  
  def self.wikiArticle?(lines)
    return lines[0].scan(/WDOC\d/).length > 0
  end
  
  def lines_to_article(lines)
    if WikiArticle.wikiArticle?(lines) then
      WikiArticle.new(
        get_id(lines),
        get_title(lines),
        get_sections(lines),
        get_acronyms(get_content(lines)),
        get_last_updated(lines),
        get_introduction(lines)
      )
    else
      return nil
    end
  end
  
  def to_s
    super + "(#{self.last_updated}) \nIntroduction: #{self.introduction.join("\n")} \nSection number: #{self.sections.length} \nSections:\n#{self.sections.join("\n")}\n- - - - - - - - - - - - - - -\n\n"
  end
  
  def self.sort_wikiArticles_by_year(wiki_articles)
    wiki_articles = wiki_articles.sort_by {|art| art.last_updated}
    hash = Hash.new { |hash, key| hash[key] = [] }
    wiki_articles.collect { |article| [article.last_updated, hash[article.last_updated].push(article)] }

    return hash
  end
  
  def self.sort_wikiArticles_by_year_only_title(wiki_articles)
    hash = Hash.new { |hash, key| hash[key] = [] }
      
    hash_table = self.sort_wikiArticles_by_year(wiki_articles)

    hash_table.each_key() {|key| 
      articles_list = Article.sort_list_of_articles_by_title(hash_table[key])
      hash_table[key] = articles_list
    }
    
    hash_table.each_key {|key|
      hash_table[key].each {|art| hash[key].push(art.title)}
    }
  
    return hash
  end
  
  def self.sort_wikiArticles_acronyms_by_year(wiki_articles)
    wiki_articles = wiki_articles.sort_by {|art| art.last_updated}
    hash = Hash.new { |hash, key| hash[key] = [] }
    wiki_articles.collect { |article| [article.last_updated, hash[article.last_updated].push(article.acronyms)] }
    return hash    
  end
  
  def self.year_of_articles(articles)
    list = []
    articles.each {|art| list << art.last_updated if art.is_a?(WikiArticle)}
    return list
  end
  
  attr_reader :last_updated, :introduction
  
  private
    def get_title(lines)
      lines[2]
    end
    
    def get_sections(lines)
      sections = get_separated_content(lines).compact
      section_titles = []
      section_titles = sections.find_all {|section| section.scan(/^\d\.\s.+/).length > 0}
      return section_titles.flatten
    end
    
    def get_id(lines) 
      lines[0]
    end
    
    def get_last_updated(lines)
      lines[1]
    end    
    
    def get_content(lines)
      ([] << get_title(lines) << ((get_separated_content(lines) - get_sections(lines)) - [get_title(lines)])).flatten!
    end
       
    def get_acronyms(lines)
      super(lines)
    end
    
    def get_introduction(lines)
      sections = get_separated_content(lines).compact
      section_titles = []
      sections.each {|section| 
        if section.scan(/^2\.\s.+/).length > 0 then break end
        section_titles << section
      }
      return section_titles.drop(1)
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