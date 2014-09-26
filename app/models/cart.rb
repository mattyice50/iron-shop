class Cart < ActiveRecord::Base

  has_many :cart_items
  has_many :items, through: :cart_items
  belongs_to :shopper, class_name: "User"

  def add item_id
    new_item = self.cart_items.new
    new_item.item_id = item_id
    new_item.save
  end

  def remove item_id
    item = self.cart_items.where(cart_id: self.id, item_id: item_id).first
    self.cart_items.delete (item)
  end

  def subtotal
    subtotal = 0
    self.items.each do |item|
      subtotal = subtotal + item.price
    end
    subtotal
  end

  def total
    total = self.subtotal * (1 + self.tax_rate)
    total.round(2)
  end

  def checkout!
    invoice = self.shopper.invoices.new
    self.items.each do |item|
      invoice.items << item
    end
    invoice.amount = self.total
    invoice
  end

  def clean
    items = self.cart_items
    items.delete_all
  end
end
