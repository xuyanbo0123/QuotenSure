require 'csv'

# polk data update
cars_csv_text = File.read('db/polk/polk.csv')
cars_csv = CSV.parse(cars_csv_text, :headers => false)
cars_csv.each do |row|
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

    trim = Trim.find_by_name(row[3])
    if trim.nil?
      trim = Trim.create!({
                              :name => row[3]
                          })
    end

    car = Car.where(:year_id => year.id, :make_id => make.id, :model_id => model.id, :trim_id => trim.id).first_or_create
    puts(car.id)
  end
end