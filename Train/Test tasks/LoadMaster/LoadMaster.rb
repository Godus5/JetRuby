# frozen_string_literal: true

require 'rspec'
# Для корректной работы тестов следует полностью очистить файл 'list_load.txt'
require 'geocoder'
require 'pry'

class LoadMaster
  def create_load(weight, length, width, height, point_of_departure, destination)
    File.open('list_load.txt', 'a') do |file|
      @load = {}
      @load[:weight] = weight.to_f
      @load[:length] = length / 100.0
      @load[:width] = width / 100.0
      @load[:height] = height / 100.0
      @load[:point_of_departure] = point_of_departure
      @load[:destination] = destination
      @load[:distance] =
        Geocoder::Calculations.distance_between(Geocoder.coordinates(@load[:point_of_departure]),
                                                Geocoder.coordinates(@load[:destination]), units: :km).round(2).to_f
      if @load[:distance].nan?
        @load[:distance] = 0
      end
      @load.each_value { |value| file.write("#{value} ") }
      capacity = @load[:length] * @load[:width] * @load[:height]
      if capacity < 1
        @load[:price] = @load[:distance]
      elsif capacity > 1
        @load[:price] = if @load[:weight] <= 10
                          2 * @load[:distance]
                        else
                          3 * @load[:distance]
                        end
      end
      file.puts(@load[:price])
    end
  end

  def print_list
    if File.exist?('list_load.txt')
      if File.size?('list_load.txt').to_i != 0
        File.open('list_load.txt', 'r') do |file|
          puts "\nСписок грузов: "
          number_load = 1
          file.readlines.each do |line|
            print_list_load = line.split(' ')
            puts "\nГруз #{number_load}. Вес: #{print_list_load[0]}\tДлина: #{print_list_load[1]}\tШирина: #{print_list_load[2]}\tВысота: #{print_list_load[3]}."
            puts "Маршрут: #{print_list_load[4]} -> #{print_list_load[5]}"
            puts "Расстояние: #{print_list_load[6]}"
            puts "Стоимость: #{print_list_load[7]}\n"
            number_load += 1
          end
        end
      else
        puts 'Файл с грузами пуст.'
      end
    else
      puts 'Файла с грузами нет. При создании груза, файл автоматически создастся.'
    end
  end

  attr_reader :load
end


describe LoadMaster, '.print_list' do
  it 'Вывод пустого файла' do
    object = LoadMaster.new
    # binding.pry
    expect { object.print_list }.to output("Файл с грузами пуст.\n").to_stdout
  end
end

describe LoadMaster, '.create_load' do
  it 'Проверка на создание груза с корректными данными' do
    object = LoadMaster.new
    object.create_load(20, 3, 3, 3, 'Россия', 'Китай')
    #binding.pry
    expect(object.load.empty?).to eq(false)
  end

  it 'Проверка на создание груза с некорректными данными' do
    object = LoadMaster.new
    object.create_load(20, 3, 3, 3, 'Россия1', 'Ингушетия2')
    #binding.pry
    expect(object.load[:distance]).to eq(0)
  end

  it 'Создание груза объёмом > 1 и весом > 10' do
    object = LoadMaster.new
    object.create_load(20, 300, 300, 300, 'Россия', 'Китай')
    # binding.pry
    expect(object.load[:price]).to eq(object.load[:distance] * 3)
  end

  it 'Создание груза объёмом > 1 и весом <= 10' do
    object = LoadMaster.new
    object.create_load(9, 300, 300, 300, 'Россия', 'Китай')
    # binding.pry
    expect(object.load[:price]).to eq(object.load[:distance] * 2)
  end

  it 'Создание груза объёмом < 1' do
    object = LoadMaster.new
    object.create_load(11, 10, 20, 30, 'Россия', 'Китай')
    # binding.pry
    expect(object.load[:price]).to eq(object.load[:distance])
  end
end

describe LoadMaster, '.print_list' do
  it 'Вывод НЕ пустого файла' do
    object = LoadMaster.new
    # binding.pry
    expect { object.print_list }.not_to output("Файл с грузами пуст.\n").to_stdout
  end
end