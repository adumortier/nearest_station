class SearchController < ApplicationController

  def index 
    conn1 = Faraday.new "https://developer.nrel.gov/api/alt-fuel-stations/v1" do |conn|
      conn.params['api_key'] = ENV['DEV_NETWORK_API_KEY']
    end
    response = conn1.get('nearest.json?') do |req|
      req.params['location'] = params["location"]
      req.params['fuel_type'] = 'ELEC'
    end
    @station = Station.new(JSON.parse(response.body, symbolize_names: true)[:fuel_stations].first)

    conn2 = Faraday.new "https://maps.googleapis.com/maps/api" do |conn|
      conn.params['key'] = ENV['GOOGLE_MAP_API_KEY']
    end
    response = conn2.get('directions/json?') do |req|
      req.params['origin'] = params["location"]
      req.params['destination'] = @station.address
    end
    result = JSON.parse(response.body, symbolize_names: true)[:routes].first[:legs].first
    @direction = Direction.new(result)
  end 

end