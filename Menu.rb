begin
require_relative 'Functions'
rescue IOError => e
  $stderr.puts e.message 
  $stderr.puts 'Finalizada la ejecución del programa.'
  exit
end

class Menu
  def self.show_menu
    puts ''
    puts 'Práctica Ruby de Paradigmas de Programación Curso 2015/2016 GIS'
    puts '------------------------------------------------------------------'
    puts 'Selecciona una opción:'
    puts '1. Mostrar los títulos de los artículos ordenados alfabéticamente y publicados en un año dado.'
    puts '2. Mostrar el listado de revistas en las que se han publicado los artículos de toda la colección.'
    puts '3. Dado un acrónimo, buscarlo en los diferentes artículos y mostrar los títulos de aquellos que contengan el acŕonimo.'
    puts '4. Dado el nombre de una revista y un acrónimo, mostrar los títulos de los artículos publicados en dicha revista que contengan el acrónimo.'
    puts '5. Dado un año de publicación, mostrar para cada artículo publicado en ese año el listado de acrónimos que contiene acompañados de sus formas expandidas.'
    puts '6. Dado un identificador de artículo, mostrar un listado de los acrónimos que contiene, acompañado del número de veces que aparece cada acrónimo en el artículo.'
    puts '7. Mostrar los títulos e identificador de todos aquellos artículos que no contengan ningún acrónimo.'
    puts '8. Dado el nombre de una revista, mostrar toda la información de los artículos publicados en dicha revista.'
    puts '9. Agrupar artículos por acrónimos.'
    puts '10. Mostrar estadísticas de los grupos.'
    puts '11. Salir.'
    
    option = gets.chomp.to_i
    
    if option > 11 || option < 1 then 
        puts 'Opción elegida incorrecta.'
    else
      case option
        when 0 
              puts (show articles_list)
        when 1
              puts 'Introduce un año: '
              year = gets.chomp
              Menu.friendly_output(Functions.articles_by_year(year))
        when 2
              Menu.friendly_output(Functions.sources())    
        when 3
              puts 'Introduce un acrónimo: '
              acronym = gets.chomp
              Menu.friendly_output(Functions.articles_by_acronym(acronym))
        when 4
              puts 'Introduce el nombre de una revista: '
              source = gets.chomp
              puts 'Introduce un acrónimo: '
              acronym = gets.chomp
              Menu.friendly_output(Functions.articles_by_source_and_acronym(source,acronym))
        when 5
              puts 'Introduce un año: '
              year = gets.chomp
              Menu.friendly_output(Functions.acronyms_by_year(year))
        when 6
              puts 'Introduce un ID: '
              id_article = gets.chomp
              Menu.friendly_output(Functions.acronyms_by_id(id_article))
        when 7
              Menu.friendly_output(Functions.articles_without_acronyms()) 
        when 8
              puts 'Introduce el nombre de una revista: '
              source = gets.chomp
              Menu.friendly_output(Functions.articles_by_source(source)) 
        when 9
              hash = Functions.group_articles()
              i = 1
              hash.each_key {|key|
                puts "Cluster #{i}\n"
                hash[key].each {|art| 
                  puts art
                }
                i = i+1
                puts
              }
        when 10
              Functions.get_stats().each do |key, value|
                puts key.to_s + ' = ' + value.to_s
              end
    
        when 11
              puts 'Ha salido del programa.'  
              exit
      end  
    end
  
    self.show_menu
  
  end
  
  def self.friendly_output(output)
    if output == [] then
      puts "No se han encontrado resultados."
    else
      puts output
    end
  end
  
  private
    def initialize
    end
end