class PriceWatches < ActiveRecord::Migration
  def change
    create_table(:price_watches) do |t|
      t.integer "shopper_id"
      t.integer "item_id"
      t.timestamps
    end
  end
end
