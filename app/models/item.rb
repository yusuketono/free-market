class Item < ApplicationRecord
  validates :name, :price, :detail, :condition, :delivery_fee_payer, :delivery_method, :delivery_days, :deal, presence: true
  validates :price, numericality:{greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999}
end
