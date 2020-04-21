class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      check_type(item)
    end
  end

  private

#Types of items
  def check_type(item)
    if item.name == "Aged Brie"
      brie(item)
    elsif item.name == "Backstage passes to a TAFKAL80ETC concert"
      pass(item)
    elsif item.name == "Sulfuras, Hand of Ragnaros"
      sulfuras(item)
    elsif item.name.start_with?("Conjured")
      conjured(item)
    else
      regular(item)
    end
  end

#Logic for Aged Brie
  def brie(item)
    quality_plus(item, 1)
    sell_in_minus(item)
  end

#Logic for Backstage passes to a TAFKAL80ETC concert
  def pass(item)
    if item.sell_in < 10 && item.sell_in > 5
      quality_plus(item, 2)
    elsif item.sell_in < 5 && item.sell_in > 0
      quality_plus(item, 3)
    elsif item.sell_in == 0
      quality_zero(item)
    else
      quality_plus(item, 1)
    end
  end

 #Logic for Sulfuras, Hand of Ragnaros
  def sulfuras(item)
  end

#Logic for regular items
  def regular(item)
    item.sell_in!=0 ? quality_minus(item, 1) : quality_minus(item, 2)
    sell_in_minus(item)
  end

#Logic for Conjured items
  def conjured(item)
    item.sell_in!=0 ? quality_minus(item, 2) : quality_minus(item, 4)
    sell_in_minus(item)
  end

#------Update Item Properties------

#quality
  def quality_plus(item, value)
    if (item.quality + value) > 50
      item.quality = 50
    else
      item.quality += value
    end
  end

  def quality_minus(item, value)
    if (item.quality - value) < 0
      quality_zero(item)
    else
      item.quality -= value
    end
  end

  def quality_zero(item)
    item.quality = 0
  end

#sell in
  def sell_in_minus(item)
    item.sell_in -= 1 if item.sell_in > 0
  end


end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end