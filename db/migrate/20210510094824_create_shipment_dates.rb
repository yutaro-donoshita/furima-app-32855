class CreateShipmentDates < ActiveRecord::Migration[6.0]
  def change
    create_table :shipment_dates do |t|

      t.timestamps
    end
  end
end
