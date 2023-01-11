require 'rails_helper'

RSpec.describe 'get all Customers' do 
  describe 'happy path' do
    it 'will return all current customers' do
      create_list(:customer, 10)

      get api_v1_customers_path

      customers = JSON.parse(response.body, symbolize_names: true)

      expect(customers[:data].count).to eq 10

      customers[:data].each do |customer|
        expect(customer).to have_key(:id)
        expect(customer[:id]).to be_a String
        expect(customer).to have_key(:type)
        expect(customer[:type]).to eq("customer")
        expect(customer).to have_key(:attributes)
        expect(customer[:attributes]).to have_key(:first_name)
        expect(customer[:attributes][:first_name]).to be_a String
        expect(customer[:attributes]).to have_key(:last_name)
        expect(customer[:attributes][:last_name]).to be_a String
        expect(customer[:attributes]).to have_key(:email)
        expect(customer[:attributes][:email]).to be_a String
        expect(customer[:attributes]).to have_key(:address)
        expect(customer[:attributes][:address]).to be_a String
      end
    end
  end
end