class FuelStationService

  def self.nearest_station_information(location)
    conn1 = Faraday.new "https://developer.nrel.gov/api/alt-fuel-stations/v1" do |conn|
      conn.params['api_key'] = ENV['DEV_NETWORK_API_KEY']
    end
    response = conn1.get('nearest.json?') do |req|
      req.params['location'] = location
      req.params['fuel_type'] = 'ELEC'
    end
    return response
  end
end