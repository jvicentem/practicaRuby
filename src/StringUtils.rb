class StringUtils
  
  def self.remove_parenthesis(string)
    string.tr('()', '')
  end
  
  def self.remove_character(string,char)
    string.tr_s(char, '') 
  end

  private
    def initialize 
    end
end