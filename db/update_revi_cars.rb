require 'csv'

# polk data update
Year.delete_all
ActiveRecord::Base.connection.reset_pk_sequence!('years')
Make.delete_all
ActiveRecord::Base.connection.reset_pk_sequence!('makes')
Model.delete_all
ActiveRecord::Base.connection.reset_pk_sequence!('models')
Trim.delete_all
ActiveRecord::Base.connection.reset_pk_sequence!('trims')
Car.delete_all
ActiveRecord::Base.connection.reset_pk_sequence!('cars')

cars_csv_text = File.read('db/revi_polk/revi_polk.csv')
cars_csv = CSV.parse(cars_csv_text, :headers => false)
cars_csv.each_with_index do |row, i|
  if row[0].to_i > 1980

    year = Year.find_by_name(row[0])
    if year.nil?
      year = Year.create!({
                              :name => row[0]
                          })
    end

    make = Make.find_by_name(row[1])
    if make.nil?
      make = Make.create!({
                              :name => row[1]
                          })
    end

    model = Model.find_by_name(row[2])
    if model.nil?
      model = Model.create!({
                                :name => row[2]
                            })
    end

    car = Car.where(:year_id => year.id, :make_id => make.id, :model_id => model.id).first_or_create
    puts(car.id)
  end
end