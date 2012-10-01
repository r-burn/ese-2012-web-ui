# a module is a namespace to avoid name collisions
module Store

  class User

    #class variable
    @@users =  []


    # generate getter and setter for name and grades
    attr_accessor :name, :credits, :items


    def self.all
      @@users
    end

    def self.by_name name
      @@users.detect{|user| user.name == name}
    end


    # factory method (constructor) on the class
    def self.named( name )
      user = self.new
      user.name = name
      user
    end

    def save
      @@users << self
    end

    # initialize is called automatically
    # when an instance is created
    def initialize
      self.credits = 100
      self.items = Array.new
    end

    def to_s
      # string interpolation
      "#{name} (#{self.credits} cr.)"
    end

    def list
      # prints the list of active items
      activeItems = Array.new
      i=0
      while i<items.length
         if items[i].active?
           activeItems.push(items[i])
         end
         i=i+1
      end
      activeItems.to_s
    end

    # @param [Item] item
    def buy(item)
      if self.credits >= item.price  && item.active?
        self.credits = self.credits-item.price
        preOwner = item.owner
        preOwner.remove(item)
        preOwner.credits = preOwner.credits + item.price
        item.owner = self
        self.add(item)
        item.active = false
        end
    end

    # @param [Item] item
    def remove(item)
      self.items.delete(item)
    end

    # @param [Item] item
    def add( item )
      self.items.push( item )
    end

  end

end