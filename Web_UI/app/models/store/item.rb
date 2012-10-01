# a module is a namespace to avoid name collisions
module Store

  class Item

    # generate getter and setter for name and grades
    attr_accessor :name, :price, :active, :owner

    # factory method (constructor) on the class
    def self.namedPriced( name, price, owner )
      item = self.new
      item.name = name
      item.price = price
      item.owner = owner
      owner.add(item)
      item
    end

    # initialize is called automatically
    # when an instance is created
    def initialize
      self.active = false
    end

    def active?
      self.active
    end

    def to_s
      # string interpolation
      "#{name} (#{self.price} cr.), belongs to #{owner}, active = #{active?} \n"
    end

  end

end