require 'rails_helper'

RSpec.describe 'Customer can update status of subscription' do
  describe 'happy path' do
    it 'can cancel an active subscription' do
      tea = create(:tea)
      customer = create(:customer)
      subscription = create(:subscription, status: 'active', customer_id: customer.id, tea: tea)

      patch api_v1_customer_subscription_path(customer, subscription),
      params: { status: 'cancelled'}

      cancelled = JSON.parse(response.body, symbolize_names: true)

      expect(subscription.customer_id).to eq(cancelled[:data][:attributes][:customer_id])
      expect(subscription.id.to_s).to eq(cancelled[:data][:id])
      expect(subscription.status).to eq('active')
      expect(cancelled[:data][:attributes][:status]).to eq('cancelled')
    end

    it 'can activate a cancelled subscription' do
      tea = create(:tea)
      customer = create(:customer)
      subscription = create(:subscription, status: 'cancelled', customer_id: customer.id, tea: tea)

      patch api_v1_customer_subscription_path(customer, subscription),
      params: { status: 'active'}

      cancelled = JSON.parse(response.body, symbolize_names: true)

      expect(subscription.customer_id).to eq(cancelled[:data][:attributes][:customer_id])
      expect(subscription.id.to_s).to eq(cancelled[:data][:id])
      expect(subscription.status).to eq('cancelled')
      expect(cancelled[:data][:attributes][:status]).to eq('active')
    end
  end
end