class Api::V1::SubscriptionsController < ApplicationController


  def index

    #use params[:id] to get the customer id from frontend/view
    customer = Customer.find(1)

    if customer
      render json: SubscriptionSerializer.new(customer.subscriptions)
    else
      render json: SubscriptionSerializer.error(404, 'Customer must exist'), status: :not_found
    end
  end

  def create
    subscription = Subscription.new(subscription_params)
    if subscription.save
      render json: SubscriptionSerializer.new(subscription), status: :created
    else
      render json: { errors: subscription.errors.full_messages }, status: :bad_request
    end
  end

  def update
    subscription = Subscription.find(params[:id])
    subscription.update(update_subscription_params)
    render json: SubscriptionSerializer.new(subscription)
  end


  private
  def subscription_params
    params.permit(:title, :price, :status, :frequency, :customer_id)
  end

  def update_subscription_params
    params.permit(:status)
  end
end
