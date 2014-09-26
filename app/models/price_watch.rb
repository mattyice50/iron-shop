class PriceWatch < ActiveRecord::Base
  belongs_to :shopper, class_name: "User"
  belongs_to :item
end
