require 'test/unit'
require '../app/models/store/item'
require '../app/models/store/user'

# syntax for inheritance
class ItemTest < Test::Unit::TestCase

  def test_list
    owner = Store::User.named('John')
    item = Store::Item.namedPriced('The Lord of The Rings, Books', 10, owner)
    item.active= true
    assert(owner.list.include?(item.to_s), "List should include active items" )
    item.active= false
    assert(!owner.list.include?(item.to_s), "List should not include inactive items" )
  end

  def test_username
    owner = Store::User.named('John')
    assert(owner.name == 'John', "Username")
  end

  def test_credits
    owner = Store::User.named('John')
    assert(!(owner.credits==0), "User should have some initial credits")
  end

  def test_initialCredits
    owner = Store::User.named('John')
    assert(owner.credits==100, "User should have 100 initial credits")
  end

  def test_buy
    seller = Store::User.named('John')
    buyer = Store::User.named('Jack')
    item = Store::Item.namedPriced('The Lord of The Rings, Books', 10, seller)
    item.active= true
    buyer.buy(item)
    assert(buyer.credits == 90, "Credits should be removed")
    assert(seller.credits == 110, "Credits should be added")
    assert(!seller.items.include?(item), "Item shouldn't be on the sellers list anymore" )
    assert(buyer.items.include?(item), "Item should be on the buyers list")
    assert(!item.active?, "Item should be inactive")
  end

  def test_not_enough_credits
    seller = Store::User.named('John')
    buyer = Store::User.named('Jack')
    item = Store::Item.namedPriced('The Lord of The Rings, Books', 101, seller)
    item.active= true
    buyer.buy(item)
    assert(seller.items.include?(item), "Item should still be on the sellers list")
    assert(buyer.credits == 100, "Credits should not change")
    assert(seller.credits == 100, "Credits should not change")
  end

  def test_not_active
    seller = Store::User.named('John')
    buyer = Store::User.named('Jack')
    item = Store::Item.namedPriced('The Lord of The Rings, Books', 10, seller)
    item.active= false
    buyer.buy(item)
    assert(seller.items.include?(item), "Item should still be on the sellers list")
    assert(buyer.credits == 100, "Credits should not change")
    assert(seller.credits == 100, "Credits should not change")
  end

end