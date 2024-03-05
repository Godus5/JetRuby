require_relative 'LoadMaster'
class Load
  def main
    load = LoadMaster.new
    while true
      puts "\nВыберите действие:"
      puts '1 - Создать груз'
      puts '2 - Вывести список грузов'
      puts '3 - Выйти из программы'
      print 'Ваш выбор: '
      case gets.chomp.to_i
      when 1
        print "Характеристики груза.\nВес - "
        weight = gets.chomp.to_f
        print 'Длина - '
        length = gets.chomp.to_f
        print 'Ширина - '
        width = gets.chomp.to_f
        print 'Высота - '
        height = gets.chomp.to_f
        print 'Пункт отправки - '
        point_of_departure = gets.chomp
        print 'Пункт назначения - '
        destination = gets.chomp
        load.create_load(weight, length, width, height, point_of_departure, destination)
        puts "Груз записан в файл"
      when 2 then load.print_list      
      when 3 then break
      else
        puts 'Такого пункта нет в меню. Выберите один из предложенных вариантов.'
        next
      end
    end
    puts 'Программа завершена.'
  end
end

Load.new.main
