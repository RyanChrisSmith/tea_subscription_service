class Subscription < ApplicationRecord
  belongs_to :customer
  belongs_to :tea

  enum status: %i[active cancelled]

  validates_presence_of :title, :price, :status, :frequency, :customer_id, :tea_id
end
