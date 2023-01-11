require 'rails_helper'

RSpec.describe 'get all Teas' do
  describe 'happy path' do
    it 'will return all current teas' do
      create_list(:tea, 10)

      get api_v1_teas_path

      teas = JSON.parse(response.body, symbolize_names: true)

      expect(teas[:data].count).to eq 10

      teas[:data].each do |tea|
        expect(tea).to have_key(:id)
        expect(tea[:id]).to be_a String
        expect(tea).to have_key(:type)
        expect(tea[:type]).to eq("tea")
        expect(tea).to have_key(:attributes)
        expect(tea[:attributes]).to have_key(:title)
        expect(tea[:attributes][:title]).to be_a String
        expect(tea[:attributes]).to have_key(:description)
        expect(tea[:attributes][:description]).to be_a String
        expect(tea[:attributes]).to have_key(:temperature)
        expect(tea[:attributes][:temperature]).to be_a String
        expect(tea[:attributes]).to have_key(:brew_time)
        expect(tea[:attributes][:brew_time]).to be_a String
      end
    end
  end
end