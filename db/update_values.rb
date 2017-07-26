require 'csv'

# values
csv_text = File.read('db/values/accident_types.csv')
csv = CSV.parse(csv_text, :headers => true)
AccidentType.delete_all
ActiveRecord::Base.connection.reset_pk_sequence!('accident_types')
csv.each do |row|
  AccidentType.create!({
                           :name => row[0],
                           :moss => row[1],
                           :display => row[2],
                           :is_display => row[3],
                           :revi => row[4]
                       })
end

csv_text = File.read('db/values/annual_mileages.csv')
csv = CSV.parse(csv_text, :headers => true)
AnnualMileage.delete_all
ActiveRecord::Base.connection.reset_pk_sequence!('annual_mileages')
csv.each do |row|
  AnnualMileage.create!({
                            :name => row[0],
                            :moss => row[1],
                            :display => row[2],
                            :is_display => row[3],
                            :revi => row[4]
                        })
end

csv_text = File.read('db/values/claim_types.csv')
csv = CSV.parse(csv_text, :headers => true)
ClaimType.delete_all
ActiveRecord::Base.connection.reset_pk_sequence!('claim_types')
csv.each do |row|
  ClaimType.create!({
                        :name => row[0],
                        :moss => row[1],
                        :display => row[2],
                        :is_display => row[3],
                        :revi => row[4]
                    })
end

csv_text = File.read('db/values/companies.csv')
csv = CSV.parse(csv_text, :headers => true)
Company.delete_all
ActiveRecord::Base.connection.reset_pk_sequence!('companies')
csv.each do |row|
  Company.create!({
                      :name => row[0],
                      :moss_code => row[1],
                      :moss => row[2],
                      :display => row[3],
                      :is_display => row[4],
                      :revi => row[5]
                  })
end

csv_text = File.read('db/values/credits.csv')
csv = CSV.parse(csv_text, :headers => true)
Credit.delete_all
ActiveRecord::Base.connection.reset_pk_sequence!('credits')
csv.each do |row|
  Credit.create!({
                     :name => row[0],
                     :moss => row[1],
                     :display => row[2],
                     :is_display => row[3],
                     :revi => row[4]
                 })
end

csv_text = File.read('db/values/damage_types.csv')
csv = CSV.parse(csv_text, :headers => true)
DamageType.delete_all
ActiveRecord::Base.connection.reset_pk_sequence!('damage_types')
csv.each do |row|
  DamageType.create!({
                         :name => row[0],
                         :moss => row[1],
                         :display => row[2],
                         :is_display => row[3],
                         :revi => row[4]
                     })
end

csv_text = File.read('db/values/coll_deducts.csv')
csv = CSV.parse(csv_text, :headers => true)
CollDeduct.delete_all
ActiveRecord::Base.connection.reset_pk_sequence!('coll_deducts')
csv.each do |row|
  CollDeduct.create!({
                         :name => row[0],
                         :moss => row[1],
                         :display => row[2],
                         :is_display => row[3],
                         :revi => row[4]
                     })
end

csv_text = File.read('db/values/comp_deducts.csv')
csv = CSV.parse(csv_text, :headers => true)
CompDeduct.delete_all
ActiveRecord::Base.connection.reset_pk_sequence!('comp_deducts')
csv.each do |row|
  CompDeduct.create!({
                         :name => row[0],
                         :moss => row[1],
                         :display => row[2],
                         :is_display => row[3],
                         :revi => row[4]
                     })
end

csv_text = File.read('db/values/educations.csv')
csv = CSV.parse(csv_text, :headers => true)
Education.delete_all
ActiveRecord::Base.connection.reset_pk_sequence!('educations')
csv.each do |row|
  Education.create!({
                        :name => row[0],
                        :moss => row[1],
                        :display => row[2],
                        :is_display => row[3],
                        :revi => row[4]
                    })
end

csv_text = File.read('db/values/garage_types.csv')
csv = CSV.parse(csv_text, :headers => true)
GarageType.delete_all
ActiveRecord::Base.connection.reset_pk_sequence!('garage_types')
csv.each do |row|
  GarageType.create!({
                         :name => row[0],
                         :moss => row[1],
                         :display => row[2],
                         :is_display => row[3],
                         :revi => row[4]
                     })
end

csv_text = File.read('db/values/marital_statuses.csv')
csv = CSV.parse(csv_text, :headers => true)
MaritalStatus.delete_all
ActiveRecord::Base.connection.reset_pk_sequence!('marital_statuses')
csv.each do |row|
  MaritalStatus.create!({
                            :name => row[0],
                            :moss => row[1],
                            :display => row[2],
                            :is_display => row[3],
                            :revi => row[4]
                        })
end

csv_text = File.read('db/values/occupations.csv')
csv = CSV.parse(csv_text, :headers => true)
Occupation.delete_all
ActiveRecord::Base.connection.reset_pk_sequence!('occupations')
csv.each do |row|
  Occupation.create!({
                         :name => row[0],
                         :moss => row[1],
                         :display => row[2],
                         :is_display => row[3],
                         :revi => row[4]
                     })
end

csv_text = File.read('db/values/relationships.csv')
csv = CSV.parse(csv_text, :headers => true)
Relationship.delete_all
ActiveRecord::Base.connection.reset_pk_sequence!('relationships')
csv.each do |row|
  Relationship.create!({
                           :name => row[0],
                           :moss => row[1],
                           :display => row[2],
                           :is_display => row[3],
                           :revi => row[4]
                       })
end

csv_text = File.read('db/values/request_coverages.csv')
csv = CSV.parse(csv_text, :headers => true)
RequestCoverage.delete_all
ActiveRecord::Base.connection.reset_pk_sequence!('request_coverages')
csv.each do |row|
  RequestCoverage.create!({
                              :name => row[0],
                              :moss => row[1],
                              :display => row[2],
                              :is_display => row[3],
                              :revi => row[4]
                          })
end

csv_text = File.read('db/values/residence_statuses.csv')
csv = CSV.parse(csv_text, :headers => true)
ResidenceStatus.delete_all
ActiveRecord::Base.connection.reset_pk_sequence!('residence_statuses')
csv.each do |row|
  ResidenceStatus.create!({
                              :name => row[0],
                              :moss => row[1],
                              :display => row[2],
                              :is_display => row[3],
                              :revi => row[4]
                          })
end

csv_text = File.read('db/values/ticket_types.csv')
csv = CSV.parse(csv_text, :headers => true)
TicketType.delete_all
ActiveRecord::Base.connection.reset_pk_sequence!('ticket_types')
csv.each do |row|
  TicketType.create!({
                         :name => row[0],
                         :moss => row[1],
                         :display => row[2],
                         :is_display => row[3],
                         :revi => row[4]
                     })
end

csv_text = File.read('db/values/vehicle_uses.csv')
csv = CSV.parse(csv_text, :headers => true)
VehicleUse.delete_all
ActiveRecord::Base.connection.reset_pk_sequence!('vehicle_uses')
csv.each do |row|
  VehicleUse.create!({
                         :name => row[0],
                         :moss => row[1],
                         :display => row[2],
                         :is_display => row[3],
                         :revi => row[4]
                     })
end

csv_text = File.read('db/values/owner_types.csv')
csv = CSV.parse(csv_text, :headers => true)
OwnerType.delete_all
ActiveRecord::Base.connection.reset_pk_sequence!('owner_types')
csv.each do |row|
  OwnerType.create!({
                        :name => row[0],
                        :moss => row[1],
                        :display => row[2],
                        :is_display => row[3],
                        :revi => row[4]
                    })
end

csv_text = File.read('db/values/genders.csv')
csv = CSV.parse(csv_text, :headers => true)
Gender.delete_all
ActiveRecord::Base.connection.reset_pk_sequence!('genders')
csv.each do |row|
  Gender.create!({
                     :name => row[0],
                     :moss => row[1],
                     :display => row[2],
                     :is_display => row[3],
                     :revi => row[4]
                 })
end

csv_text = File.read('db/values/lic_statuses.csv')
csv = CSV.parse(csv_text, :headers => true)
LicStatus.delete_all
ActiveRecord::Base.connection.reset_pk_sequence!('lic_statuses')
csv.each do |row|
  LicStatus.create!({
                        :name => row[0],
                        :moss => row[1],
                        :display => row[2],
                        :is_display => row[3],
                        :revi => row[4]
                    })
end

csv_text = File.read('db/values/age_lics.csv')
csv = CSV.parse(csv_text, :headers => true)
AgeLic.delete_all
ActiveRecord::Base.connection.reset_pk_sequence!('age_lics')
csv.each do |row|
  AgeLic.create!({
                     :name => row[0],
                     :moss => row[1],
                     :display => row[2],
                     :is_display => row[3],
                     :revi => row[4]
                 })
end

csv_text = File.read('db/values/commute_days.csv')
csv = CSV.parse(csv_text, :headers => true)
CommuteDay.delete_all
ActiveRecord::Base.connection.reset_pk_sequence!('commute_days')
csv.each do |row|
  CommuteDay.create!({
                         :name => row[0],
                         :moss => row[1],
                         :display => row[2],
                         :is_display => row[3],
                         :revi => row[4]
                     })
end

csv_text = File.read('db/values/continuous_years.csv')
csv = CSV.parse(csv_text, :headers => true)
ContinuousYear.delete_all
ActiveRecord::Base.connection.reset_pk_sequence!('continuous_years')
csv.each do |row|
  ContinuousYear.create!({
                             :name => row[0],
                             :moss => row[1],
                             :display => row[2],
                             :is_display => row[3],
                             :revi => row[4]
                         })
end

csv_text = File.read('db/values/is_insureds.csv')
csv = CSV.parse(csv_text, :headers => true)
IsInsured.delete_all
ActiveRecord::Base.connection.reset_pk_sequence!('is_insureds')
csv.each do |row|
  IsInsured.create!({
                        :name => row[0],
                        :moss => row[1],
                        :display => row[2],
                        :is_display => row[3],
                        :revi => row[4]
                    })
end

csv_text = File.read('db/values/is_sr22s.csv')
csv = CSV.parse(csv_text, :headers => true)
IsSr22.delete_all
ActiveRecord::Base.connection.reset_pk_sequence!('is_sr22s')
csv.each do |row|
  IsSr22.create!({
                     :name => row[0],
                     :moss => row[1],
                     :display => row[2],
                     :is_display => row[3],
                     :revi => row[4]
                 })
end

csv_text = File.read('db/values/residence_months.csv')
csv = CSV.parse(csv_text, :headers => true)
ResidenceMonth.delete_all
ActiveRecord::Base.connection.reset_pk_sequence!('residence_months')
csv.each do |row|
  ResidenceMonth.create!({
                             :name => row[0],
                             :moss => row[1],
                             :display => row[2],
                             :is_display => row[3],
                             :revi => row[4]
                         })
end

csv_text = File.read('db/values/residence_years.csv')
csv = CSV.parse(csv_text, :headers => true)
ResidenceYear.delete_all
ActiveRecord::Base.connection.reset_pk_sequence!('residence_years')
csv.each do |row|
  ResidenceYear.create!({
                            :name => row[0],
                            :moss => row[1],
                            :display => row[2],
                            :is_display => row[3],
                            :revi => row[4]
                        })
end

csv_text = File.read('db/values/years_with_companies.csv')
csv = CSV.parse(csv_text, :headers => true)
YearsWithCompany.delete_all
ActiveRecord::Base.connection.reset_pk_sequence!('years_with_companies')
csv.each do |row|
  YearsWithCompany.create!({
                               :name => row[0],
                               :moss => row[1],
                               :display => row[2],
                               :is_display => row[3],
                               :revi => row[4]
                           })
end