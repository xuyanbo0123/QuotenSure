# Google Geo
GoogleGeo.delete_all
ActiveRecord::Base.connection.reset_pk_sequence!('google_geos')
GoogleGeo.copy_from 'db/google/google_geos.csv'