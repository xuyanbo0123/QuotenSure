require 'rubygems'
require 'json'
require 'net/http'

class Car
  attr_accessor :year, :make, :model, :trim
  @@uri = URI.parse('http://www.quotelab.com/js/polk.json');
  def initialize(year, make, model, trim)
    @year = year
    @make = make
    @model = model
    @trim = trim
  end

  def to_csv(outfile)
    outfile.puts "#{@year},#{@make},#{@model},#{@trim}"
  end

  def get_data
    post_data = Net::HTTP.post_form(@@uri, {'year'=>@year, 'make'=>@make, 'model'=>@model})
    JSON.parse(post_data.body)['all']
  end
end

csv_file = File.open('polk.csv', 'w')
years = %w(2014 2015 2016)
years.each{|year|
  Car.new(year, '', '', '').get_data.each{ |make|
    Car.new(year, make, '', '').get_data.each{ |model|
      Car.new(year, make, model, '').get_data.each{ |trim|
        Car.new(year, make, model, trim).to_csv(csv_file)
      }
    }
  }
}
csv_file.close
