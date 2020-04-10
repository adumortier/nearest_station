require 'rails_helper'

RSpec.describe "As a user" , type: :feature do 

  describe "When I select Turing and search for nearest station" do 

    it "it shows me the address of the nearest station and also the directions" do
      visit '/'
      select 'Turing', from: :location
      click_on 'Find Nearest Station'
      expect(current_path).to eq('/search')

      expect(page).to have_css('.station')
      expect(first(".name").text).to_not be_empty
      expect(first(".address").text).to_not be_empty
      expect(first(".fuel_type").text).to_not be_empty
      expect(first(".access_times").text).to_not be_empty
    end

  end

end

# As a user
# When I visit "/"
# And I select "Turing" form the start location drop down (Note: Use the existing search form)
# And I click "Find Nearest Station"
# Then I should be on page "/search"
# Then I should see the closest electric fuel station to me.
# For that station I should see
# - Name
# - Address
# - Fuel Type
# - Access Times
# I should also see:
# - the distance of the nearest station (should be 0.1 miles)
# - the travel time from Turing to that fuel station (should be 1 min)
# - The direction instructions to get to that fuel station
#   "Turn left onto Lawrence St Destination will be on the left"