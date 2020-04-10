class GoogleDirectionService

  def self.direction_to_location(origin, destination)
    conn = Faraday.new "https://maps.googleapis.com/maps/api" do |conn|
      conn.params['key'] = ENV['GOOGLE_MAP_API_KEY']
    end
    response = conn.get('directions/json?') do |req|
      req.params['origin'] = origin
      req.params['destination'] = destination
    end
    return response
  end

end