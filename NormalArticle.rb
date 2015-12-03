require_relative 'Article'

class NormalArticle < Article
  
  def initialize(id, title, sections, acronyms, source, abstract, year)
    super(id, title, '--', sections, acronyms)
    @source, @abstract, @year = source, abstract, year
  end
  
  def self.create_empty_normalArticle
    NormalArticle.new('','',[],[],'','',0)
  end
  
  def self.normalArticle?(lines)
    return (lines[1].scan(/\d+/).length > 0) && (lines[2].scan(/\d+/).length > 0)
  end
  
  def lines_to_article(lines)
    if NormalArticle.normalArticle?(lines) then
      NormalArticle.new(
        get_id(lines),
        get_title(lines),
        get_sections(lines),
        get_acronyms(get_content(lines)),
        get_source(lines),
        get_abstract(lines),
        get_year(lines)
      )
    else
      return nil
    end
  end
  
  def to_s
    super + "Source: #{self.source} \nAbstract: #{self.abstract} \nYear: #{self.year}\n\n"
  end
  
  def self.sort_normalArticles_by_year(normal_articles)
    normal_articles = normal_articles.sort_by {|art| art.year}
    hash = Hash.new { |hash, key| hash[key] = [] }
    normal_articles.collect { |article| [article.year, hash[article.year].push(article)] }
    return hash
  end
  
  def self.sort_normalArticles_by_source(normal_articles)
    normal_articles = normal_articles.sort_by {|art| art.source}
    hash = Hash.new { |hash, key| hash[key] = [] }
    normal_articles.collect { |article| [article.source, hash[article.source].push(article)] }
    return hash
  end
  
  attr_reader :source, :abstract, :year
  
  private
    def get_title(lines)
      get_separated_content(lines)[0]
    end
    
    def get_sections(lines)
      sections = get_separated_content(lines).drop(2)
      section_titles = []
      sections.each_with_index {|section, index| if index.even? then section_titles << section if !section.empty? end}
      return section_titles
    end
  
    def get_source(lines)
      lines[0]
    end
    
    def get_id(lines) 
      lines[1]
    end

    def get_year(lines)
      lines[2]
    end    

    def get_abstract(lines)
      get_separated_content(lines)[1]
    end
    
    def get_content(lines)
      (([] << get_title(lines) << ((get_separated_content(lines) - get_sections(lines)) - [get_title(lines)])) << get_abstract(lines)).flatten!
    end

    def get_acronyms(lines)
      super(lines)
    end

end

# TEST
#art = NormalArticle.new("","",[],[],"","",0)
# lines = ["source","id","year","--","title","--","abstract","--","section title 1","section content 1","--","section title 2","section content 2","--"]
# puts art.get_source(lines);
# puts art.get_id(lines);
# puts art.get_year(lines);
# puts art.get_title(lines);
# puts art.get_abstract(lines);
# puts art.get_sections(lines);
# puts art.get_acronyms(lines);
# puts art.list_of_lines_to_articles([lineas])
# puts art.to_s()
# puts NormalArticle.list_of_lines_to_articles([lines])
# puts NormalArticle.normalArticle?(['','11111','a'])
#p NormalArticle.sort_normalArticles_by_year([NormalArticle.new("","",[],[],"","",2015),NormalArticle.new("","",[],[],"","",2015),NormalArticle.new("","",[],[],"","",2016)])