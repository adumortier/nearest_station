class SearchController < ApplicationController

  def index 
    conn = Faraday.new "https://developer.nrel.gov/api/alt-fuel-stations/v1" do |conn|
      conn.params['api_key'] = ENV['DEV_NETWORK_API_KEY']
    end
    response = conn.get('nearest.json?') do |req|
      req.params['location'] = params["location"]
      req.params['fuel_type'] = 'ELEC'
    end
    @station = Station.new(JSON.parse(response.body, symbolize_names: true)[:fuel_stations].first)
  end 

end