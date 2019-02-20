class Market
  attr_reader :name, :vendors

  def initialize(name)
    @name = name
    @vendors = []
  end

  def add_vendor(vendor)
    @vendors << vendor
  end

  def vendor_names
    @vendors.map do |vendor|
      vendor.name
    end
  end

  def vendors_that_sell(item)
    @vendors.select do |vendor|
      vendor.inventory[item] != 0
    end
  end

  def sorted_item_list
    total_inventory.keys.sort
  end

  def total_inventory
    market_inventory = Hash.new(0)
    @vendors.each do |vendor|
      vendor.inventory.each do |item, count|
        market_inventory[item] += count
      end
    end
    market_inventory
  end

  def sell_from_vendors(item, count)
    vendors = vendors_that_sell(item)
    vendors.each do |vendor|
      if count <= vendor.inventory[item]
        vendor.inventory[item] -= count
        count = 0
      elsif count >= vendor.inventory[item]
        count = count - vendor.inventory[item]
        vendor.inventory[item] = 0
      end
    end
  end

  def sell(item, count)
    market_inventory = total_inventory
    if market_inventory[item] >= count
      sell_from_vendors(item, count)
      return true
    elsif market_inventory[item] < count
      return false
    end
  end
end
