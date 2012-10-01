require 'test/unit'
require '../app/models/store/item'
require '../app/models/store/user'

# syntax for inheritance
class StoreSimulationTest < Test::Unit::TestCase

  def test_simu
    john = Store::User.named('John')
    jack = Store::User.named('Jack')
    item1 = Store::Item.namedPriced('Gartentisch XL', 50, john)
    item1.active=true
    item2 = Store::Item.namedPriced('DVD', 10, jack)
    puts("Gartentisch Item: #{item1}")
    puts("DVD Item: #{item2}")
    puts("Jack's List:\n #{jack.list}")
    puts("John's List:\n #{john.list}")
    puts("Jack buys John's Gartentisch!")
    jack.buy(item1)
    puts("Jack's List:\n #{jack.list}")
    puts("John's List:\n #{john.list}")
    puts("John tries to buy Jack's DVD!")
    john.buy(item2)
    puts("Jack's List:\n #{jack.list}")
    puts("John's List:\n #{john.list}")
    puts("DVD Activation!")
    item2.active=true;
    puts("John tries again to buy Jack's DVD!")
    john.buy(item2)
    puts("Jack's List:\n #{jack.list}")
    puts("John's List:\n #{john.list}")
    puts("DVD Activation!")

  end
end