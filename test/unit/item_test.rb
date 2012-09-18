require 'test_helper'

class ItemTest < ActiveSupport::TestCase
  test "item has description" do
    m = Merchant.new
    i = Item.new
    i.price = 7.0
    i.merchant = m
    assert !i.save
  end

  test "item has price" do
    m = Merchant.new
    i = Item.new
    i.description = "dinosaur bones"
    i.merchant = m
    assert !i.save
  end

  test "item has merchant" do
    i = Item.new
    i.description = "tacos"
    i.price = 1.0
    assert !i.save
  end

  test "save item" do
    m = Merchant.new
    i = Item.new
    i.price = 7.0
    i.description = "spaghetti"
    i.merchant = m
    assert i.save
  end
end
