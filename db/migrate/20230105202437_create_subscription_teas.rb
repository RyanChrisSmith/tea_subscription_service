class CreateSubscriptionTeas < ActiveRecord::Migration[5.2]
  def change
    create_table :subscription_teas do |t|
      t.references :tea, null: false, foreign_key: true
      t.references :subscription, null: false, foreign_key: true

      t.timestamps
    end
  end
end