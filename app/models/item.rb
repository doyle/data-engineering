class Item < ActiveRecord::Base
  belongs_to :merchant
  attr_accessible :description, :price, :merchant
  
  validates :description, :presence => true
  validates :price, :presence => true
  validates :merchant, :presence => true
end
