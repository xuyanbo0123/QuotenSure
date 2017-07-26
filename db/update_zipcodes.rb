# zip_codes
ZipCode.delete_all
ActiveRecord::Base.connection.reset_pk_sequence!('zip_codes')
ZipCode.copy_from 'db/usps/usps_zips.csv'