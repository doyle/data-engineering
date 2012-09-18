require 'test_helper'

class TransactionTest < ActiveSupport::TestCase

  def setup
    @i = Item.new
    @c = Customer.new
  end

  test "transaction has quantity" do
    t = Transaction.new
    t.customer = @c
    t.item = @i
    
    assert !t.save
  end

  test "transaction has customer" do
    t = Transaction.new
    t.item = @i
    t.quantity = 3 

    assert !t.save
  end

  test "transaction has item" do
    t = Transaction.new
    t.customer = @c
    t.quantity = 3

    assert !t.save
  end

  test "save transaction" do
    t = Transaction.new
    t.customer = @c
    t.item = @i
    t.quantity = 3

    assert t.save
  end

  test "value" do
    @i.price = 10
    t = Transaction.new
    t.customer = @c
    t.item = @i
    t.quantity = 3

    assert_equal 30, t.value
  end

end
