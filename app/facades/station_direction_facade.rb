class StationDirectionFacade

  def initialize(location) 

    response = FuelStationService.nearest_station_information(location)
    station_info = JSON.parse(response.body, symbolize_names: true)[:fuel_stations].first
    @station = Station.new(station_info)

    response = GoogleDirectionService.direction_to_location(location, @station.address)
    direction_info = JSON.parse(response.body, symbolize_names: true)[:routes].first[:legs].first
    @direction = Direction.new(direction_info)

    
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