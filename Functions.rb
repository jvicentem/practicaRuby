require_relative 'ArticlesMap'
require_relative 'Cluster'
require_relative 'IOUtils'

class Functions
  def self.initialize_articlesMaps_and_cluster()
    begin
    articles_list = IOUtils.new().get_articles()
    rescue IOError => e
      raise e
    end
    
    ArticlesMap.init(articles_list)
    
    hash_tables_list = []
    
    hash_tables_list << ArticlesMap.sort_articles_by_acronym() << 
      ArticlesMap.sort_articles_by_source() << 
      ArticlesMap.sort_articles_by_year_only_title() << 
      ArticlesMap.sort_articles_by_acronym_only_title() <<
      ArticlesMap.sort_articles_by_source_and_acronym() <<
      ArticlesMap.sort_acronyms_by_year() <<
      ArticlesMap.sort_acronyms_by_id() <<
      ArticlesMap.sort_articles_without_acronyms(hash_tables_list[0]) <<
      Cluster.new(articles_list)
      
   return hash_tables_list
  end
  
  @@articlesMaps = Functions.initialize_articlesMaps_and_cluster()
    
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
  
  def self.get_sort_articles_by_cluster
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
    self.get_sort_articles_by_acronym_only_title_hash_table[acronym]
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
    self.get_sort_acronyms_by_id_hash_table()[id]
  end
  
  #7
  def self.articles_without_acronyms()
    self.get_sort_articles_without_acronyms_hash_table
  end
  
  #8
  def self.articles_by_source(source)
    return self.get_sort_articles_by_source_hash_table()[source]
  end
  
  #9
  def self.group_articles
    self.get_sort_articles_by_cluster.sort_articles_by_cluster_only_id_and_title
  end
  
  #10
  def self.get_stats
    cluster = self.get_sort_articles_by_cluster
    
    stats = {
      'Number of clusters ' => cluster.number_of_clusters,
      'Average number of scientific articles ' => cluster.average_number_of_NormalArticles,
      'Average number of WikiPedia articles ' => cluster.average_number_of_WikiArticles,
      'Number of clusters with all articles written in the same year ' => cluster.number_of_clusters_with_articles_written_in_the_same_year,
      'Number of clusters with all articles written in the different years ' => cluster.number_of_clusters_with_articles_written_in_the_different_year,
      'Number of clusters with only one article ' => cluster.number_of_clusters_with_one_article
    }
  end
    
  private
    def initialize
    end
end

# TEST
#p Functions.articles_by_source("Biochemia Medica")
#p Functions.get_sort_articles_by_source_hash_table()
#p ArticlesMap.sort_articles_by_source()
#p ArticlesMap.sort_articles_by_source()["Biochemia Medica"]
#p Functions.get_sort_articles_by_source_hash_table()[:"Biochemia Medica"]
#p Functions.get_sort_articles_by_source_hash_table()[:'Biochemia Medica']
#p Functions.get_sort_articles_by_source_hash_table()[:'"Biochemia Medica"']
#p Functions.get_sort_articles_by_source_hash_table()[:"\"Biochemia Medica\""]
#p Functions.get_sort_articles_by_source_hash_table()["Biochemia Medica"]
#p Functions.get_sort_articles_by_source_hash_table()['Biochemia Medica']
#p Functions.get_sort_articles_by_source_hash_table()['"Biochemia Medica"']
#p Functions.get_sort_articles_by_source_hash_table()["\"Biochemia Medica\""]
#p calificaciones = {"ISI" => 10, "PP" => 10}["ISI"]
