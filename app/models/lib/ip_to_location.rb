class IpToLocation < ActiveRecord::Base
  acts_as_copy_target
  def as_json(params={})
    super(only: [:city_name, :region_name], methods: :state_abbr)
  end

  def state_abbr
    STATE_TO_ABBR[self.region_name.upcase]
  end

  def self.state_pairs
    STATE_TO_ABBR.to_a
  end

  def self.selected_id
    nil
  end

  def self.find_by_ip(ip_address)
    ip_array = ip_address.split('.')
    ip_number = 16777216*ip_array[0].to_i + 65536*ip_array[1].to_i + 256*ip_array[2].to_i + ip_array[3].to_i
    IpToLocation.where("ip_from < ? AND ip_to > ?", ip_number, ip_number).first
  end

  STATE_TO_ABBR = {
      'ALABAMA' => 'AL',
      'ALASKA' => 'AK',
      'ARIZONA' => 'AZ',
      'ARKANSAS' => 'AR',
      'CALIFORNIA' => 'CA',
      'COLORADO' => 'CO',
      'CONNECTICUT' => 'CT',
      'DELAWARE' => 'DE',
      'DISTRICT OF COLUMBIA' => 'DC',
      'FLORIDA' => 'FL',
      'GEORGIA' => 'GA',
      'HAWAII' => 'HI',
      'IDAHO' => 'ID',
      'ILLINOIS' => 'IL',
      'INDIANA' => 'IN',
      'IOWA' => 'IA',
      'KANSAS' => 'KS',
      'KENTUCKY' => 'KY',
      'LOUISIANA' => 'LA',
      'MAINE' => 'ME',
      'MARYLAND' => 'MD',
      'MASSACHUSETTS' => 'MA',
      'MICHIGAN' => 'MI',
      'MINNESOTA' => 'MN',
      'MISSISSIPPI' => 'MS',
      'MISSOURI' => 'MO',
      'MONTANA' => 'MT',
      'NEBRASKA' => 'NE',
      'NEVADA' => 'NV',
      'NEW HAMPSHIRE' => 'NH',
      'NEW JERSEY' => 'NJ',
      'NEW MEXICO' => 'NM',
      'NEW YORK' => 'NY',
      'NORTH CAROLINA' => 'NC',
      'NORTH DAKOTA' => 'ND',
      'OHIO' => 'OH',
      'OKLAHOMA' => 'OK',
      'OREGON' => 'OR',
      'PENNSYLVANIA' => 'PA',
      'RHODE ISLAND' => 'RI',
      'SOUTH CAROLINA' => 'SC',
      'SOUTH DAKOTA' => 'SD',
      'TENNESSEE' => 'TN',
      'TEXAS' => 'TX',
      'UTAH' => 'UT',
      'VERMONT' => 'VT',
      'VIRGINIA' => 'VA',
      'WASHINGTON' => 'WA',
      'WEST VIRGINIA' => 'WV',
      'WISCONSIN' => 'WI',
      'WYOMING' => 'WY'
  }
end