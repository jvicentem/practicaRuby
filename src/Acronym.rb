class Acronym
  
  def initialize (acronym,meaning)
    @acronym, @meaning = acronym, meaning
  end
  
  #private
    # http://rubular.com/
    def acronym? (word)
      return word.scan(/\A[\(+[A-Z]+]\w+\-?\d*\)[.:;,]?\Z/).length > 0
    end
  
  attr_reader :acronym, :meaning
end

# TEST
# acr = Acronym.new("a","b")
# puts acr.acronym?('(ABC)')
# puts acr.acronym?('(ABC-1)')