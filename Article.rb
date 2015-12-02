require_relative 'Acronym'

class Article

  def initialize(id, title, separator, sections, acronyms)
    @id = id
    @title = title 
    @separator = separator 
    @sections = sections
    @acronyms = acronyms
  end

=begin  
  def self.descendants
    list = []
    Dir.glob('./**/*.rb').each {|classs| list << classs.scan(/\w+[aA]rticle/)}
    return list.flatten!
  end
=end
  
  def get_separated_content(lines)
    lines.drop(3).delete_if {|element| element == self.separator}
  end
  
  def get_acronyms(lines)
    lines.each do |line|
      words_list = line.split(/\s/)
      words_list.each_with_index {|word, index|
                                    acronyms << Acronym.get_meaning(word,words_list[0...index]) if Acronym.acronym?(word)
                                 }
    end
    return acronyms
  end
  
  def get_content(lines)
    [] << self.get_title(lines) << ((get_separated_content(lines) - self.get_sections(lines)) - [self.get_title(lines)])
  end
  
  def to_s
    return "ID: #{self.id} \nTitle: #{self.title} \nSections: #{self.sections} \nAcronyms: #{self.acronyms.join(',')}\n"
  end
  
  attr_reader :id, :title, :separator, :sections, :acronyms
end

# TEST

# art = Article.new("","","--",[],[])
# puts art.get_separated_content(["a","a","a","--","b","c","--","d","e"])
# p Article.descendants()