class Item < ApplicationRecord
  validates :name, :price, :detail, :condition, :delivery_fee_payer, :delivery_method, :delivery_days, :deal, presence: true
  validates :price, numericality:{greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999}
  
  belongs_to :category
  belongs_to :seller, class_name: "User"
  belongs_to :buyer, class_name: "User", optional: :true
end
