class Item < ApplicationRecord
  belongs_to :category
  has_many :selling_items, class_name: "Item", foreign_key: "seller_id"
  has_many :bought_items, class_name: "Item", foreign_key: "buyer_id"

  validates :name, :price, :detail, :condition, :delivery_fee_payer, :delivery_method, :delivery_days, :deal, presence: true
  validates :price, numericality:{greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999}
end
