class FuelStationService

  def self.nearest_station_information(location)
    response = conn.get('nearest.json?') do |req|
      req.params['location'] = location
      req.params['fuel_type'] = 'ELEC'
    end
    return response
  end

  def self.conn 
    Faraday.new "https://developer.nrel.gov/api/alt-fuel-stations/v1" do |conn|
      conn.params['api_key'] = ENV['DEV_NETWORK_API_KEY']
    end
  end
end