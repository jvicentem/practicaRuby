require_relative 'Acronym'

class Article

  def initialize(id, title, separator, sections, acronyms)
    @id = id
    @title = title 
    @separator = separator 
    @sections = sections
    @acronyms = acronyms
  end
  
  attr_reader :id, :title, :separator, :sections, :acronyms
  
  protected
    def get_separated_content(lines)
      lines.drop(3).delete_if {|element| element == self.separator}
    end
    
    def get_acronyms(lines)
      acronyms = []
      lines.compact.each do |line|
        words_list = line.split(/\s/)
        words_list.each_with_index {|word, index|                                               
                                      if Acronym.acronym?(word) then
                                        acr = Acronym.get_meaning(word,words_list[0...index])
                                        
                                        acronyms << acr.count_appearances!(lines) if !acronyms.include?(acr)
                                      end
                                   }
        special_acr = Acronym.special_acronyms(words_list)
        
        special_acr.each {|sp|
          acronyms << sp.count_appearances!(lines) if !acronyms.include?(sp)
        }
      end
      return acronyms
    end
    
  public 
    def to_s
      return "- - - - - - - - - - - - - - -\nTitle: #{self.title} "
    end
  
    def self.sort_list_of_articles_by_title(articles) 
      return articles.sort { |art1,art2| art1.title <=> art2.title }
    end
    
    def self.sort_articles_by_acronym(articles) 
      hash = Hash.new { |hash, key| hash[key] = [] }
      articles.collect { |article|
        if article.acronyms.length > 0 then
          article.acronyms.each {|acr| [acr, hash[acr].push(article)]} 
        else
          ["No acronyms", hash["No acronyms"].push(article)]
        end
      }
      
      hash.each_key {|key| 
        articles_list = hash[key]
        articles_list_sorted = articles_list.sort { |art1,art2| art1.title <=> art2.title }
        hash[key] = articles_list_sorted
      }
      
      return Acronym.convert_object_key_to_acronym_key(hash)
    end
    
    def self.sort_articles_by_acronym2(articles) 
      hash = Hash.new { |hash, key| hash[key] = [] }
      articles.each { |article|
        if article.acronyms.length > 0 then
          article.acronyms.each {|acr| 
            list_aux = []
            already_in = false
            hash.each_key() {|key| 
              if key == acr then 
                list_aux = hash[key]
                hash.delete(key)
                already_in = true
              end
            }

            if !already_in then
              hash[acr] << article 
            else
              hash[acr] = (list_aux << article)
            end
          } 
        else
          hash["No acronyms"] << article
        end
      }
      
      return Acronym.convert_object_key_to_acronym_key(hash)
    end
    
    def self.sort_titles_by_acronym(articles) 
      hash_acronyms = self.sort_articles_by_acronym(articles)
      
      hash_acronyms.each_key {|key| 
        titles_list = []
        hash_acronyms[key].each {|art| titles_list << art.title}
        hash_acronyms[key] = titles_list
      }
      
      return hash_acronyms
    end
    
    def self.sort_acronyms_by_id(articles)
      hash = Hash.new { |hash, key| hash[key] = [] }
      articles.each {|art| hash[art.id] = art.acronyms}
      return hash
    end
    
    def self.get_id_and_title_of_articles_without_acronyms(hash_table)
      articles_list = []
      hash_table["No acronyms"].each {|art| articles_list << [art.id,art.title]}
      return articles_list
    end

    def self.sort_articles_by_most_repeated_acronyms(articles) 
      hash = Hash.new { |hash, key| hash[key] = [] }
        
      articles.each {|art|
        if art.acronyms.length > 0 then
          acronyms = art.acronyms
          most_repeated_acronym = Acronym.most_repeated_acronym(acronyms)
          most_repeated_acronym = most_repeated_acronym.acronym
          hash[most_repeated_acronym] << art
        end
      }
      
      return Acronym.convert_object_key_to_acronym_key(hash)
    end
    
    def self.sort_articles_by_most_repeated_acronyms_only_title_and_id(hash_table)      
      hash = Hash.new { |hash, key| hash[key] = [] }
      
      hash_table.each_key {|key|
        articles = hash_table[key]
        
        id_and_title_list = []
          
        articles.each{|art| id_and_title_list << (art.id + " - " + art.title)}
          
        hash[key] = id_and_title_list
      }
      
      return hash
    end
  
end
