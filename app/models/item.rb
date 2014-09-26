# == Schema Information
#
# Table name: items
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  description :text
#  price       :float
#  seller_id   :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class Item < ActiveRecord::Base
  validates_presence_of :title, :description, :price, :seller_id
  validates :price, numericality: { greater_than_or_equal_to: 0 }

  belongs_to :seller, class_name: "User"
  has_many :carts, through: :cart_items
  has_many :cart_items

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/


  include PgSearch
  pg_search_scope :search, against: [:title, :description],
    using: { tsearch: { dictionary: "english" } }

  def self.text_search(query)
    if query.present?
      where("title @@ :q or description @@ :q", q: query)
    else
      all
    end
  end
end
