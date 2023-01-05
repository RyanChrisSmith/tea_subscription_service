require 'rails_helper'

RSpec.describe 'Customer Subscription Tea Request', type: :request do

  describe 'happy path' do
    it 'subscribes a customer to a tea subscription' do
      customer = create(:customer)

      post "/api/v1/customers/#{customer.id}/subscriptions",
      params: { title: "Introduction Pack",
                price: 13.99,
                frequency: "monthly", }

      new_subscription = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq 201

      expect(new_subscription).to be_a Hash
      expect(new_subscription[:data]).to have_key(:id)
      expect(new_subscription[:data][:id]).to be_a String
      expect(new_subscription[:data]).to have_key(:type)
      expect(new_subscription[:data][:type]).to be_a String
      expect(new_subscription[:data]).to have_key(:attributes)
      expect(new_subscription[:data][:attributes]).to be_a Hash
      expect(new_subscription[:data][:attributes]).to have_key(:title)
      expect(new_subscription[:data][:attributes][:title]).to eq("Introduction Pack")
      expect(new_subscription[:data][:attributes]).to have_key(:price)
      expect(new_subscription[:data][:attributes][:price]).to eq(13.99)
      expect(new_subscription[:data][:attributes]).to have_key(:status)
      expect(new_subscription[:data][:attributes][:status]).to eq("active")
      expect(new_subscription[:data][:attributes]).to have_key(:frequency)
      expect(new_subscription[:data][:attributes][:frequency]).to eq("monthly")
    end
  end

  describe 'sad path' do
    it 'will return an error if frequency of the subscription is missing' do
      customer = create(:customer)

      post "/api/v1/customers/#{customer.id}/subscriptions",
      params: { title: "Introduction Pack",
                price: 13.99, }

      new_subscription = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq 400

      expect(new_subscription).to be_a Hash
      expect(new_subscription).to have_key(:errors)
      expect(new_subscription[:errors]).to eq(["Frequency can't be blank"])
    end

    it 'will return an error if title of the subscription is missing' do
      customer = create(:customer)

      post "/api/v1/customers/#{customer.id}/subscriptions",
      params: { price: 13.99,
                frequency: 'monthly', }

      new_subscription = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq 400

      expect(new_subscription).to be_a Hash
      expect(new_subscription).to have_key(:errors)
      expect(new_subscription[:errors]).to eq(["Title can't be blank"])
    end

    it 'will return an error if price of the subscription is missing' do
      customer = create(:customer)

      post "/api/v1/customers/#{customer.id}/subscriptions",
      params: { title: "Introduction Pack",
                frequency: 'monthly', }

      new_subscription = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq 400

      expect(new_subscription).to be_a Hash
      expect(new_subscription).to have_key(:errors)
      expect(new_subscription[:errors]).to eq(["Price can't be blank"])
    end
  end
end