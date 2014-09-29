class PriceWatchMailer < ActionMailer::Base
  default from: 'receipts@iron-shop.example.com'
  def price_alert item
    @item = item
    item.price_watches.each do |pricewatch|
      u = User.find_by_id pricewatch.shopper_id
      mail to: u.email, subject: "Price alert on your tracked item"
    end
  end
end
