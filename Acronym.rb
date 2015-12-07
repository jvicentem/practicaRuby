require_relative 'StringUtils'

class Acronym
  ACRONYM_REGEX = "[A-Z]{2,}[A-Z0-9]*\\-?\\d*"
  
  def initialize (acronym,meaning)
    @acronym, @meaning, @times = acronym, meaning, 0
  end
  
  attr_reader :acronym, :meaning, :times
  attr_writer :times
  
  def count_appearances(lines)
    lines.each {|line| 
      words_list = line.split(/\s/)
      words_list.each { |word|
        word_modified = word.downcase
        acronym_modified = self.acronym.downcase
        new_appearance if StringUtils.string_match_expr?(word_modified,acronym_modified)
      }
    }
    
    return self
  end
  
  def new_appearance
    self.times = self.times + 1
  end
  
  def self.most_repeated_acronym(acronyms)
    max_acr = nil
    times = 0
    
    acronyms.each {|acr|
      if acr.times > times then
        max_acr = acr 
        times = acr.times
      end
    }
    
    return max_acr
  end
  
  def to_s
    "Acrónimo = #{self.acronym()}\nSignificado = #{self.meaning}\nVeces = #{self.times}\n\n"
  end
  
  def ==(acr)
   self.acronym == acr.acronym
  end
  
  def self.create_empty_Acronym
    Acronym.new('','')
  end
  
  # http://rubular.com/
  def self.acronym?(word)
    StringUtils.string_match_expr?(word,"\\A\\(#{ACRONYM_REGEX}\\)[.:;,]?\\Z")
  end
  
  def self.get_meaning(acronym, partial_line)
    acronym_cleaned = if StringUtils.has_any_of_these_characters_at_the_end?(acronym,[',','.',':',';']) then
                        StringUtils.remove_last_char!(acronym) 
                      else 
                        acronym 
                      end
    temp_empty_acronym = Acronym.create_empty_Acronym
    
    if (meaning = temp_empty_acronym.criterion1(acronym_cleaned, partial_line)).meaning.length > 0 then
    elsif (meaning = temp_empty_acronym.criterion2(acronym_cleaned, partial_line)).meaning.length > 0
      elsif (meaning = temp_empty_acronym.criterion3(acronym_cleaned, partial_line)).meaning.length > 0
        elsif (meaning = temp_empty_acronym.criterion4(acronym_cleaned, partial_line)).meaning.length > 0
        else
          return Acronym.new(StringUtils.remove_parenthesis(acronym_cleaned), "No se ha encontrado significado para este acrónimo")
        end
          
    return meaning
  end

  def criterion1(acronym, words)
    acronym_without_parenthesis = StringUtils.remove_parenthesis(acronym)
    
    improved_list_of_words = words.reverse
    
    reversed_acronym = acronym_without_parenthesis.reverse
    
    temp_meaning = []
    acronym_letter_index = 0
    
    improved_list_of_words.each {|word|
      if (temp_meaning.length != acronym_without_parenthesis.length) then
        if (word[0].downcase == reversed_acronym[acronym_letter_index].downcase) && #Si la primera letra de la palabra coincide con la letra del acrónimo que toca y además... 
          ((!StringUtils.has_any_of_these_characters_at_the_end?(word,[',','.',':',';']) && !acronym_no_parenthesis?(word)) || #La palabra es válida y no es un acrónimo o...
           (StringUtils.has_any_of_these_characters_at_the_end?(word,[',','.',':',';']) && (temp_meaning == (acronym_without_parenthesis.length - 1))) #La palabra no es válida pero es la última, entonces forma parte del significado
          ) then
            temp_meaning.push(word)
            acronym_letter_index  = acronym_letter_index + 1
        else #Si la palabra no cumple todo lo anterior, entonces no vale
          temp_meaning = []
          reversed_acronym = acronym_without_parenthesis.reverse
          acronym_letter_index = 0
        end  
      else
        break
      end
    }
    return Acronym.new(acronym_without_parenthesis, temp_meaning.join(" "))
  end

  def criterion2(acronym, words)
    acronym_without_parenthesis = StringUtils.remove_parenthesis(acronym)
    acronym_without_parenthesis = StringUtils.remove_character(acronym_without_parenthesis,'-')
    
    improved_list_of_words = words.reverse
    
    reversed_acronym = acronym_without_parenthesis.reverse
    
    temp_meaning = []
    acronym_letter_index = 0
    already_a_word_in_the_middle = false
    
    improved_list_of_words.each {|word|
      if (temp_meaning.length != (acronym_without_parenthesis.length+1)) then
        if (word[0].downcase == reversed_acronym[acronym_letter_index].downcase) && #Si la primera letra de la palabra coincide con la letra del acrónimo que toca y además... 
          ((!StringUtils.has_any_of_these_characters_at_the_end?(word,[',','.',':',';']) && !acronym_no_parenthesis?(word)) || #La palabra es válida y no es un acrónimo o...
           (StringUtils.has_any_of_these_characters_at_the_end?(word,[',','.',':',';']) && (temp_meaning == (acronym_without_parenthesis.length - 1))) #La palabra no es válida pero es la última, entonces forma parte del significado
          ) then
            temp_meaning.push(word)
            acronym_letter_index  = acronym_letter_index + 1
        else #Si la palabra no cumple todo lo anterior, entonces...
          if !already_a_word_in_the_middle && #Si no hay ya una palabra que no coincida en el medio 
            !temp_meaning.empty? && #y no va a ser la primera palabra del significado 
            !acronym_no_parenthesis?(word) && !Acronym.acronym?(word) && #y además no es un acrónimo 
             !StringUtils.has_any_of_these_characters_at_the_end?(word,[',','.',':',';']) then #y la palabra es válida, entonces la tenemos en cuenta
            already_a_word_in_the_middle = true
            temp_meaning.push(word)
          else #Si aún así no se cumple lo anterior, se descarta
            temp_meaning = []
            reversed_acronym = acronym_without_parenthesis.reverse
            acronym_letter_index = 0
          end
        end  
      else
        break
      end
    }
         
    return Acronym.new(acronym_without_parenthesis, temp_meaning.join(" "))
  end
  
  def criterion3(acronym, words)
    acronym_without_parenthesis = StringUtils.remove_parenthesis(acronym)
    
    improved_list_of_words = words.reverse
    
    reversed_acronym = acronym_without_parenthesis.reverse
    
    temp_meaning = []
      
    meaning_found = false
    
    improved_list_of_words.each_with_index {|word, index|
      next_word = if (index+1) < improved_list_of_words.length then improved_list_of_words[index+1] else word end
      
      if (temp_meaning.length != 2) then
        unless condition_for_criterion3(word, acronym_without_parenthesis) then
          if condition_for_criterion3(next_word, acronym_without_parenthesis) then
            temp_meaning.push(word)
            temp_meaning.push(next_word)
            break              
          else
            temp_meaning = []
          end
        end
      end
    }
    
    return Acronym.new(acronym_without_parenthesis, temp_meaning.join(" "))
  end
  
  def criterion4(acronym, words)
    acronym_without_parenthesis = StringUtils.remove_parenthesis(acronym)
    improved_list_of_words = words.reverse
    
    reversed_acronym = acronym_without_parenthesis.reverse
    
    temp_meaning = []
      
    improved_list_of_words.each {|word|  
      valid_word = false
      if (!reversed_acronym.empty?()) then
        if !Acronym.acronym?(word) && !acronym_no_parenthesis?(word) && #Si la palabra no es un acrónimo
          (!StringUtils.has_any_of_these_characters_at_the_end?(word,[',','.',':',';']) || (StringUtils.has_any_of_these_characters_at_the_end?(word,[',','.',':',';']) && temp_meaning.length == 1)) then #Y además es válida o si no lo es se trata de la última palabra del significado, entonces se tiene en cuenta
          word.reverse.each_char {|letter| 
                                      if reversed_acronym.length > 1 then
                                        if letter.downcase == reversed_acronym[0].downcase then 
                                          valid_word = true
                                          reversed_acronym.slice!(0)
                                        end                                        
                                      else
                                        #p "prueba ",word,reversed_acronym
                                        if word[0].downcase == reversed_acronym[0].downcase then 
                                          valid_word = true
                                          reversed_acronym.slice!(0)
                                        else
                                          valid_word = false
                                          reversed_acronym = acronym_without_parenthesis.reverse
                                          temp_meaning = []
                                        end           
                                        
                                        break                            
                                      end
                                 }
        end
                
      end
      
      if valid_word then
        temp_meaning.push(word)        
      end
    }
    
    return Acronym.new(acronym_without_parenthesis, temp_meaning.join(" "))
  end         

  private
    def acronym_no_parenthesis?(word)
      StringUtils.string_match_expr?(word,"\\A#{ACRONYM_REGEX}[.:;,]?\\Z")
    end
    
    def condition_for_criterion3(word, acronym_without_parenthesis)
      #Si la palabra es válida y no es un acrónimo y además las primeras n letras de la palabra coinciden con las n letras del acrónimo, entonces la palabra se tiene en cuenta
      !StringUtils.has_any_of_these_characters_at_the_end?(word,[',','.',':',';']) && !acronym_no_parenthesis?(word) && (word[0...acronym_without_parenthesis.length].downcase == acronym_without_parenthesis.downcase)
    end

end

# TEST
# acr = Acronym.new('a','b')
# puts acr.acronym?('(ABC)')
# puts acr.acronym?('(ABC-1)')
# words = ['amarillo','casa','Blanco','(ACB)']
# improved_list_of_words = words[0...3].reverse
# puts improved_list_of_words[0].downcase
# puts acr.criterion1('(ACB)',['pepe','amarillo','casa','pepe','blanco','amarillo','casa.','blanco','amarillo','CSA','blanco','Amarillo1','Casa2','Blanco3','(ACB)'],14)
# puts acr.criterion2('(ACB)',['amarillo','casa','intruso','blanco'])
# puts acr.criterion3('(USH)',['usher','syndrome','(USH)'])
# puts acr.criterion4('(MTHFR)',['methylenetetrahydrofolate','reductase'])
# puts Acronym.get_meaning('(OXR1)',"Recently, oxidation resistance 1".split(/\s/))
#p Acronym.acronym?('(A).')
#p Acronym.get_meaning('(OXR1)',"Recently, oxidation resistance 1".split(/\s/)).count_appearances(["Recently, (OXR1) oxidation resistance 1 (OXR1) (OXR1) (OXR1)"])
