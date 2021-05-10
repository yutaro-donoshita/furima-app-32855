class CreateDeliveryFees < ActiveRecord::Migration[6.0]
  def change
    create_table :delivery_fees do |t|

      t.timestamps
    end
  end
end
