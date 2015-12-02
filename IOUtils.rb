=begin
Esta clase va a ser con la cual otras clases se van a comunicar 
para extraer artículos almacenados en medios externos.

La idea es que si se cambia el medio externo (por ejemplo, los
artículos dejan de estar en archivos de texto y pasan a estar en
una base de datos) sea el método de esta clase y el atributo 
external_source los que se modifiquen y así otras clases estén 
aisladas de los detalles concretos de extracción de información 
de artículos en medios externos.
=end
require_relative 'TextFileUtils'

class IOUtils
  def initialize
    @external_source = TextFileUtils.new("./docsUTF8prueba")
  end
  
  def read_files
    self.external_source.read_files
  end
  
  attr_reader :external_source
end

#TEST
#puts IOUtils.new().read_files()