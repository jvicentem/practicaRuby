require_relative 'Article'

class NormalArticle < Article
  
  def initialize(id, title, sections, acronyms, source, abstract, year)
    super(id, title, '--', sections, acronyms)
    @source, @abstract, @year = source, abstract, year
  end

  attr_reader :source, :abstract, :year
  
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
    super + "(#{self.year}) \nAbstract: #{self.abstract} \nSection number: #{self.sections.length} \nSections:\n#{self.sections.join("\n")}\n- - - - - - - - - - - - - - -\n\n"
  end
  
  def self.create_empty_normalArticle
    NormalArticle.new('','',[],[],'','',0)
  end
  
  def self.normalArticle?(lines)                                  
    return (StringUtils.string_match_expr?(lines[1],"\\d+")) && (StringUtils.string_match_expr?(lines[2],"\\d+"))
  end
  
  def self.sort_normalArticles_by_year(normal_articles)
    normal_articles = normal_articles.sort_by {|art| art.year}
    hash = Hash.new { |hash, key| hash[key] = [] }
    normal_articles.collect { |article| [article.year, hash[article.year].push(article)] }

    return hash
  end
  
  def self.sort_normalArticles_by_year_only_title(normal_articles)
    hash = Hash.new { |hash, key| hash[key] = [] }
      
    hash_table = self.sort_normalArticles_by_year(normal_articles)

    hash_table.each_key() {|key| 
      articles_list = Article.sort_list_of_articles_by_title(hash_table[key])
      hash_table[key] = articles_list
    }

    hash_table.each_key {|key|
      hash_table[key].each {|art| hash[key].push(art.title)}
    }

    return hash
  end
  
  def self.sort_normalArticles_by_source(normal_articles)
    articles = normal_articles.sort_by {|art| art.title}
    hash = Hash.new { |hash, key| hash[key] = [] }
    articles.each { |article| 
      hash[article.source.chomp[1..-1]] << article
    }
    return hash
  end
  
  def self.sort_normalArticles_by_source_only_title(normal_articles)
    normal_articles = normal_articles.sort_by {|art| art.source}
    hash = Hash.new { |hash, key| hash[key] = [] }
    normal_articles.collect { |article| [article.source, hash[article.source].push(article.title)] }
    return hash
  end
  
  def self.sort_normalArticles_acronyms_by_year(normal_articles)
    normal_articles = normal_articles.sort_by {|art| art.year}
    hash = Hash.new { |hash, key| hash[key] = [] }
    normal_articles.collect { |article| [article.year, hash[article.year].push(article.acronyms)] }
    return hash    
  end
  
  def self.year_of_articles(articles)
    list = []
    articles.each {|art| list << art.year if art.is_a?(NormalArticle)}
    return list
  end
  
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
      source = lines[0]
      if source[1] == ' ' then
        source[1] = ''
      end
      return source
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
#p NormalArticle.sort_normalArticles_by_source([NormalArticle.new("","A",[],[],"S1","",2015),NormalArticle.new("","B",[],[],"S2","",2015),NormalArticle.new("","C",[],[],"S3","",2016)])["S1"]