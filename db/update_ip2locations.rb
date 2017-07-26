# ip2location
IpToLocation.delete_all
ActiveRecord::Base.connection.reset_pk_sequence!('ip_to_locations')
IpToLocation.copy_from 'db/ip2location/ip2location_2014.csv'