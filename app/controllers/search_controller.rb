class SearchController < ApplicationController

  def index
    @station_direction = StationDirectionFacade.new(params["location"])
  end 

end