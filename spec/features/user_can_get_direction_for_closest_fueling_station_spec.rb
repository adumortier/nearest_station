require 'rails_helper'

RSpec.describe "As a user" , type: :feature do 

  describe "When I select Turing and search for nearest station" do 

    it "it shows me the address of the nearest station and also the directions" do
      visit '/'
      select 'Turing', from: :location
      click_on 'Find Nearest Station'
      expect(current_path).to eq('/search')

      within('.station') do
        expect(first(".name").text).to_not be_empty
        expect(first(".address").text).to_not be_empty
        expect(first(".fuel_type").text).to_not be_empty
        expect(first(".access_times").text).to_not be_empty
      end

      within('.direction') do
        expect(first(".distance").text).to_not be_empty
        expect(first(".travel_time").text).to_not be_empty
        expect(first(".direction_instructions").text).to_not be_empty
      end
    end

  end

end