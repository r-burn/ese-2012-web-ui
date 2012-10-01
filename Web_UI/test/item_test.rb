require 'test/unit'
require '../app/models/store/item'
require '../app/models/store/user'

# syntax for inheritance
class ItemTest < Test::Unit::TestCase

  def test_to_s
    owner = Store::User.named('John')
    item = Store::Item.namedPriced('Gartentisch XL', 100, owner)
    assert(item.to_s.include?('Gartentisch XL'), "String should include the Itemname" )
    assert(item.to_s.include?('100'), "String should include the price")
    assert(item.to_s.include?(owner.to_s), "String should include the name of the owner")
  end

  def test_initialization_owner
    owner = Store::User.named('John')
    item = Store::Item.namedPriced('Gartentisch XL', 100, owner)
    assert(item.owner = owner, "Owner should be ok")
  end

  def test_initialization_price
    owner = Store::User.named('John')
    item = Store::Item.namedPriced('Gartentisch XL', 100, owner)
    assert(item.price == 100, "Item-Price should be ok")
  end

  def test_initialization_name
    owner = Store::User.named('John')
    item = Store::Item.namedPriced('Gartentisch XL', 100, owner)
    assert(item.name == 'Gartentisch XL', "Item-Name should be ok")
  end

  def test_initialization_ownerList
    owner = Store::User.named('John')
    item = Store::Item.namedPriced('Gartentisch XL', 100, owner)
    assert(owner.items.include?(item), "The owner should have the item in his list")
  end

  def test_initialization_inactive
    owner = Store::User.named('John')
    item = Store::Item.namedPriced('Gartentisch XL', 100, owner)
    assert(!item.active?, "Item should be inactive after initialization")
    item.active = true
    assert(item.active)
  end

end