require_relative 'ClusterByMostRepeatedAcronyms'

class Cluster
  
  def initialize(articles_list)
    @cluster_specific = ClusterByMostRepeatedAcronyms.new(articles_list)
  end
  
  attr_reader :cluster_specific
  
  def sort_articles_by_cluster_only_id_and_title()
    self.cluster_specific.sort_articles_by_most_repeated_acronyms_only_title_and_id()
  end

  def number_of_clusters
    self.cluster_specific.number_of_clusters()
  end
  
  def average_number_of_NormalArticles
    self.cluster_specific.average_number_of_NormalArticles()
  end
  
  def average_number_of_WikiArticles
    self.cluster_specific.average_number_of_WikiArticles()
  end
  
  def number_of_clusters_with_articles_written_in_the_same_year
    self.cluster_specific.number_of_clusters_with_articles_written_in_the_same_year()
  end
  
  def number_of_clusters_with_articles_written_in_the_different_year
    self.cluster_specific.number_of_clusters_with_articles_written_in_the_different_year()
  end
  
  def number_of_clusters_with_one_article
    self.cluster_specific.number_of_clusters_with_one_article()
  end
  
end

