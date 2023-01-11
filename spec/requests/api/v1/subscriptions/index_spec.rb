require 'rails_helper'

describe 'Get all subscriptions' do
  describe 'happy path' do
    it 'will show all subscriptions for a customer regardless of status' do
      tea = create(:tea)
      customers = create_list(:customer, 3)
      original_subscriptions = create_list(:subscription, 4, customer: customers[0], tea: tea)

      get api_v1_customer_subscriptions_path(customers[0])

      expect(response).to be_successful
      expect(response.status).to eq 200

      data = JSON.parse(response.body, symbolize_names: true)
      all_subscriptions = data[:data]

      expect(all_subscriptions.count).to eq 4
      expect(original_subscriptions.first.customer_id).to eq(customers[0].id)

      all_subscriptions.each do |subscript|
        expect(subscript).to have_key(:id)
        expect(subscript[:id]).to be_a String
        expect(subscript).to have_key(:type)
        expect(subscript[:type]).to be_a String
        expect(subscript).to have_key(:attributes)
        expect(subscript[:attributes]).to be_a Hash
        expect(subscript[:attributes]).to have_key(:title)
        expect(subscript[:attributes][:title]).to be_a String
        expect(subscript[:attributes]).to have_key(:price)
        expect(subscript[:attributes][:price]).to be_a Float
        expect(subscript[:attributes]).to have_key(:status)
        expect(subscript[:attributes][:status]).to be_a String
        expect(subscript[:attributes]).to have_key(:frequency)
        expect(subscript[:attributes][:frequency]).to be_a String
        expect(subscript[:attributes]).to have_key(:customer_id)
        expect(subscript[:attributes][:customer_id]).to be_a Integer
      end
    end
  end

  describe 'sad path' do
    it 'will return an error if a customer with given id doesnt exist' do
      tea = create(:tea)
      customer = create(:customer)
      subscriptions = create_list(:subscription, 4, customer: customer, tea: tea)
      faulty_id = customer.id + 1

      get api_v1_customer_subscriptions_path(faulty_id)
      data = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq 404

      expect(data).to have_key(:error)
      expect(data[:error]).to eq 404
      expect(data).to have_key(:message)
      expect(data[:message]).to eq("Customer must exist")
    end
  end
end