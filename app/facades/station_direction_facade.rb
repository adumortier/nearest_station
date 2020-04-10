class StationDirectionFacade

  def initialize(location) 
    conn1 = Faraday.new "https://developer.nrel.gov/api/alt-fuel-stations/v1" do |conn|
      conn.params['api_key'] = ENV['DEV_NETWORK_API_KEY']
    end
    response = conn1.get('nearest.json?') do |req|
      req.params['location'] = location
      req.params['fuel_type'] = 'ELEC'
    end
    @station = Station.new(JSON.parse(response.body, symbolize_names: true)[:fuel_stations].first)

    conn2 = Faraday.new "https://maps.googleapis.com/maps/api" do |conn|
      conn.params['key'] = ENV['GOOGLE_MAP_API_KEY']
    end
    response = conn2.get('directions/json?') do |req|
      req.params['origin'] = location
      req.params['destination'] = @station.address
    end
    result = JSON.parse(response.body, symbolize_names: true)[:routes].first[:legs].first
    @direction = Direction.new(result)
  end 

  def name 
    @station.name
  end

  def address
    @station.address
  end

  def fuel_type
    @station.fuel_type
  end

  def access_times
    @station.access_times
  end

  def distance
    @direction.distance
  end

  def travel_time
    @direction.travel_time
  end

  def direction_instructions
    @direction.direction_instructions
  end
  
end