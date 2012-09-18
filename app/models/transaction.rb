class Transaction < ActiveRecord::Base
  attr_accessible :quantity, :customer, :item

  belongs_to :customer
  belongs_to :item

  validates :quantity, :presence => true
  validates :customer, :presence => true
  validates :item, :presence => true

  def value
    return item.price * quantity
  end
end
