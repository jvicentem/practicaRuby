require_relative 'StringUtils'

class Acronym
  
  def initialize (acronym,meaning)
    @acronym, @meaning = acronym, meaning
  end
  
  attr_reader :acronym, :meaning
  
  def to_s
    "Acrónimo = #{self.acronym()}\nSignificado = #{self.meaning}"
  end
  
  #private
    # http://rubular.com/
    def self.acronym?(word)
      return word.scan(/\A[\(+[A-Z]+][A-Z0-9]+\-?\d*\)[.:;,]?\Z/).length > 0
    end
    
    def self.get_meaning(acronym)
    end
    
    def acronym_no_parenthesis?(word)
      return word.scan(/\A[A-Z]+[A-Z0-9]+\-?\d*[.:;,]?\Z/).length > 0
    end
    
    def valid?(word)
      last_char = word[-1]
      last_char != ',' && last_char != '.' && last_char != ':' && last_char != ';'
    end
    
    def criterion1(acronym, words, acronym_position)
      acronym_without_parenthesis = StringUtils.remove_parenthesis(acronym)
      
      improved_list_of_words = words.reverse
      
      reversed_acronym = acronym_without_parenthesis.reverse
      
      temp_meaning = []
      acronym_letter_index = 0
      
      improved_list_of_words.each {|word|
        if (temp_meaning.length != acronym_without_parenthesis.length) then
          if (word[0].downcase == reversed_acronym[acronym_letter_index].downcase) && #Si la primera letra de la palabra coincide con la letra del acrónimo que toca y además... 
            ((valid?(word) && !acronym_no_parenthesis?(word)) || #La palabra es válida y no es un acrónimo o...
             (!valid?(word) && (temp_meaning == (acronym_without_parenthesis.length - 1))) #La palabra no es válida pero es la última, entonces forma parte del significado
            ) then
              temp_meaning.unshift(word)
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
=begin
      # Aquí hay cosas que están sin corregir.
      word_index = 0
      acronym_letter_index = 0
      while ((temp_meaning.length != acronym_without_parenthesis.length) && 
             (word_index < acronym_position) && 
             (acronym_letter_index < acronym_without_parenthesis.length))
             
        word = improved_list_of_words[word_index].downcase
        
        if word[0] == reversed_acronym[acronym_letter_index].downcase then
          if valid?(word) && !acronym?(word) then
            temp_meaning.unshift(word)
            acronym_letter_index  = acronym_letter_index + 1
          else
            if temp_meaning = (acronym_without_parenthesis.length - 1) then
              temp_meaning.unshift(word)
              acronym_letter_index  = acronym_letter_index + 1
            else
              temp_meaning = []
              reversed_acronym = acronym.reverse
              acronym_letter_index = 0              
            end
          end
        else
          temp_meaning = []
          reversed_acronym = acronym.reverse
          acronym_letter_index = 0
        end    
        word_index = word_index + 1    
      end
=end
      return Acronym.new(acronym_without_parenthesis, temp_meaning.join(" "))
    end

    def criterion2(acronym, words, acronym_position)
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
            ((valid?(word) && !acronym_no_parenthesis?(word)) || #La palabra es válida y no es un acrónimo o...
             (!valid?(word) && (temp_meaning == (acronym_without_parenthesis.length - 1))) #La palabra no es válida pero es la última, entonces forma parte del significado
            ) then
              temp_meaning.unshift(word)
              acronym_letter_index  = acronym_letter_index + 1
          else #Si la palabra no cumple todo lo anterior, entonces...
            if !already_a_word_in_the_middle && #Si no hay ya una palabra que no coincida en el medio 
              !temp_meaning.empty? && #y no va a ser la primera palabra del significado 
              !acronym_no_parenthesis?(word) && !Acronym.acronym?(word) && #y además no es un acrónimo 
               valid?(word) then #y la palabra es válida, entonces la tenemos en cuenta
              already_a_word_in_the_middle = true
              temp_meaning.unshift(word)
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
    
    def criterion3(words)
      acronym_without_parenthesis = StringUtils.remove_parenthesis(acronym)
      
      improved_list_of_words = words.reverse
      
      reversed_acronym = acronym_without_parenthesis.reverse
      
      temp_meaning = []
        
      meaning_found = false
      
      improved_list_of_words.each {|word|
        if (temp_meaning.length != 2) then
          if meaning_found then
            temp_meaning.unshift(word)
            break
          else
            if valid?(word) && !acronym_no_parenthesis?(word) && (word[0...acronym_without_parenthesis.length].downcase == acronym_without_parenthesis.downcase) then
              temp_meaning.unshift(word)
              meaning_found = true
            else
              temp_meaning = []
            end
          end
        end
      }
      
      return Acronym.new(acronym_without_parenthesis, temp_meaning.join(" "))
    end
    
    def criterion4(words)
    end
    
    def criterion5(words)
    end            

end

# TEST
acr = Acronym.new('a','b')
# puts acr.acronym?('(ABC)')
# puts acr.acronym?('(ABC-1)')
# words = ['amarillo','casa','Blanco','(ACB)']
# improved_list_of_words = words[0...3].reverse
# puts improved_list_of_words[0].downcase
# puts acr.criterion1('(ACB)',['pepe','amarillo','casa','pepe','blanco','amarillo','casa.','blanco','amarillo','CSA','blanco','Amarillo1','Casa2','Blanco3','(ACB)'],14)
# puts acr.criterion2('(ACB)',['amarillo','casa','intruso','blanco','(ACB)'],4)
