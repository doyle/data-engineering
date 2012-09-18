# TsvImporter parses a tab separated file and imports it into the database
#
# Author:: Christian Doyle
class TsvImporter

  # Imports a tsv file into the database 
  #
  # file string representing a path to a file
  # 
  # returns the value of all of the transactions in the file 
  def import_file f
    f.gets
    value = 0
    line = f.gets
    while line != nil
      value += import_row line
      line = f.gets
    end
    f.close
    value
  end

  # Imports a single line from a tsv file into the database
  # the file is expected to be formatted as follows:
  #
  # purchaser name \t item description \t item price \t purchase count \t  merchant address \t  merchant name
  #
  # If the customer, merchant, or item are already in the database they will be used for the new 
  # transaction. Every all to this function creates a new transaction
  # 
  # line a row from a tsv file
  #
  # returns the value of the transaction
  def import_row line
    parts = line.split("\t")

    customer = Customer.find_or_create_by_name(parts[0])
    merchant = Merchant.find_or_create_by_name_and_address(parts[5], parts[4])
    item = merchant.items.find_or_create_by_description_and_price(parts[1], parts[2])
    transaction = customer.transactions.create(:quantity => parts[3], :item => item)
    
    transaction.value
  end
end
