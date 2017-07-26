require 'csv'

# polk initial data
cars_csv_text = File.read('db/polk/cars.csv')
cars_csv = CSV.parse(cars_csv_text, :headers => false)
Car.delete_all
ActiveRecord::Base.connection.reset_pk_sequence!('cars')
cars_csv.each do |row|
  Car.create!({
                  :year_id => row[0],
                  :make_id => row[1],
                  :model_id => row[2],
                  :trim_id => row[3]
              })
end

years_csv_text = File.read('db/polk/years.csv')
years_csv = CSV.parse(years_csv_text, :headers => false)
Year.delete_all
ActiveRecord::Base.connection.reset_pk_sequence!('years')
years_csv.each do |row|
  Year.create!({
                   :name => row[0]
               })
end

makes_csv_text = File.read('db/polk/makes.csv')
makes_csv = CSV.parse(makes_csv_text, :headers => false)
Make.delete_all
ActiveRecord::Base.connection.reset_pk_sequence!('makes')
makes_csv.each do |row|
  Make.create!({
                   :name => row[0]
               })
end

models_csv_text = File.read('db/polk/models.csv')
models_csv = CSV.parse(models_csv_text, :headers => false)
Model.delete_all
ActiveRecord::Base.connection.reset_pk_sequence!('models')
models_csv.each do |row|
  Model.create!({
                    :name => row[0]
                })
end

trims_csv_text = File.read('db/polk/trims.csv')
trims_csv = CSV.parse(trims_csv_text, :headers => false)
Trim.delete_all
ActiveRecord::Base.connection.reset_pk_sequence!('trims')
trims_csv.each do |row|
  Trim.create!({
                   :name => row[0]
               })
end