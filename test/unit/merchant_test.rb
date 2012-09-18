require 'test_helper'

class MerchantTest < ActiveSupport::TestCase
  test "merchant has name" do
    m = Merchant.new
    m.address = "somewhere"
    assert !m.save
  end

  test "merchant has address" do
    m = Merchant.new
    m.name = "Dinosaurs inc."
    assert !m.save
  end

  test "save merchant" do
    m = Merchant.new :name => "Merchant", :address => "somewhere"
    assert m.save
  end
end
