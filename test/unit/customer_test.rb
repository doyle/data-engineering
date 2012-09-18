require 'test_helper'

class CustomerTest < ActiveSupport::TestCase
  test "customer has a name" do
    c = Customer.new
    assert !c.save

    c.name = "somebody"
    assert c.save
  end
end
