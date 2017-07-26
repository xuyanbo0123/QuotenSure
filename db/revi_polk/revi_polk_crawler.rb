require 'rubygems'
require 'json'
require 'net/http'

class ReviCar
  attr_accessor :year, :make, :model
  @@uri = URI.parse('http://automotive.bestquotes.com/ajax/vehicle/polk?')

  def initialize(year, make, model)
    @year = year
    @make = make
    @model = model
  end

  def to_csv(outfile)
    outfile.puts "#{@year},#{@make},#{@model}"
  end

  def get_data
    post_data = Net::HTTP.post_form(@@uri, {'year' => @year, 'make' => @make})
    JSON.parse(post_data.body)['Items']
  end
end

csv_file = File.open('db/revi_polk/revi_polk.csv', 'a')

(1981..2015).each do |year|
  puts year
  ReviCar.new(year.to_s, '', '').get_data.each { |makeKV|
    ReviCar.new(year.to_s, makeKV['Key'], '').get_data.each { |modelKV|
      ReviCar.new(year.to_s, makeKV['Key'], modelKV['Key']).to_csv(csv_file)
    }
  }
end

csv_file.close