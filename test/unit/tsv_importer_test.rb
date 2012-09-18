require 'test_helper'

class TsvImporterTest < ActiveSupport::TestCase

  def setup
    @customer_name = "Snake Plissken"
    @item_description = "$10 off $20 of food"
    @item_price = "10.0"
    @purchase_quantity = "2"
    @merchant_address = "987 Fake St"
    @merchant_name = "Bob's Pizza"
    @row = "#{@customer_name}\t#{@item_description}\t#{@item_price}\t#{@purchase_quantity}\t" \
    "#{@merchant_address}\t#{@merchant_name}"

    @tsv = TsvImporter.new
  end

  def teardown
    ActiveRecord::Base.subclasses.each(&:delete_all)
  end

  test "import row" do
    @tsv.import_row(@row)

    c = Customer.find_by_name(@customer_name)
    m = Merchant.find_by_name_and_address(@merchant_name, @merchant_address)
    i = Item.find_by_description_and_price(@item_description, @item_price)

    assert c, "customer does not exist"
    assert m, "merchant does not exist"    
    assert i, "item does not exist"
    assert_equal i, m.items.find_by_description_and_price(@item_description, @item_price), "item belongs to merchant"
    assert !c.transactions.where(:quantity => @purchase_quantity, :item_id => i).empty?, "transaction does not exist"
   end

  test "import file" do
    data = "purchaser name\titem description\titem price\tpurchase count\tmerchant address\tmerchant name\n" +
      @row + "\n" + 
      "Amy Pond\t$30 of awesome for $10\t10.0\t5\t456 Unreal Rd\tTom's Awesome Shop\n" +
      "Marty McFly\t$20 Sneakers for $5\t5.0\t1\t123 Fake St\tSneaker Store Emporium\n" +
      "Snake Plissken\t$20 Sneakers for $5\t5.0\t4\t123 Fake St\tSneaker Store Emporium"

    
    value = @tsv.import_file(StringIO.new(data))
    puts value
    assert_equal 95.0, value, "computed value does not match"
  end

  test "customers are only added once" do
    quantity Customer, :name, @customer_name
  end

  test "items are only added once" do
    quantity Item, :description, @item_description
  end

  test "merchants are only added once" do
    quantity Merchant, :name, @merchant_name
  end

  def quantity(record, key, value)
    @tsv.import_row @row
    @tsv.import_row @row

    records = record.where key => value
    assert_equal 1, records.size, "record should only appear once"
  end

  test "every transaction is added" do
    @tsv.import_row @row
    @tsv.import_row @row
    
    c = Customer.find_by_name @customer_name
    assert_equal 2, c.transactions.size, "there should be two transactions"
  end

  test "value computed correctly" do
    assert_equal 20.0, @tsv.import_row(@row)
  end

end
