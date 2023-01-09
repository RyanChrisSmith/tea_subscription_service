class SubscriptionSerializer
  include JSONAPI::Serializer
  attributes :title, :price, :status, :frequency, :customer_id, :tea_id

  def self.error(status, message)
    { error: status,
      message: message }
  end
end
