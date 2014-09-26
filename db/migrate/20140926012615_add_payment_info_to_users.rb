class AddPaymentInfoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :payment_info, :string
  end
end
