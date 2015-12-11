class StringUtils
  
  def self.remove_parenthesis(string)
    string.tr('()', '')
  end
  
  def self.remove_character(string,char)
    string.tr_s(char, '') 
  end
  
  def self.remove_last_char!(string)
    string.chop!
  end
  
  def self.has_any_of_these_characters_at_the_end?(word,char_list)
    last_char = word[-1] 
    char_list.include?(last_char)
  end
  
  def self.string_match_expr?(string,regex)
    string.scan(/#{regex}/).length > 0
  end

  private
    def initialize 
    end
end
