class GildedRose

  def initialize(items)
    @items = items
  end

  def check_type(item)
    if item.name == "Aged Brie"
      brie(item)
    elsif item.name == "Backstage passes to a TAFKAL80ETC concert"
      pass(item)
    elsif item.name == "Sulfuras, Hand of Ragnaros"
      sulfuras(item)
    else
      regular(item)
    end
  end

  def brie(item)
    quality_plus_one(item)
    sell_in_minus(item)
  end

  def pass(item)
    if item.sell_in < 10 && item.sell_in > 5
      quality_plus_two(item)
    elsif item.sell_in < 5 && item.sell_in > 0
      quality_plus_three(item)
    elsif item.sell_in == 0
      quality_zero(item)
    else
      quality_plus_one(item)
    end
  end
  
  def sulfuras(item)
  end

  def regular(item)
    item.sell_in != 0 ? quality_minus_one(item) : quality_minus_two(item)
    sell_in_minus(item)
  end

  def quality_plus_one(item)
    item.quality += 1 if item.quality < 50
  end

  def quality_plus_two(item)
    if item.quality == 49
      quality_plus_one(item)
    else
      item.quality += 2
    end
  end

  def quality_plus_three(item)
    if item.quality == 48
      quality_plus_two(item)
    elsif item.quality == 49
      quality_plus_one(item)
    else
      item.quality += 3
    end
  end

  def quality_minus_one(item)
    item.quality -= 1 if item.quality > 0
  end

  def quality_minus_two(item)
    if item.quality == 1
      quality_minus_one(item)
    elsif item.quality > 0
      item.quality -= 2
    end
  end

  def quality_zero(item)
    item.quality = 0
  end

  def sell_in_minus(item)
    item.sell_in -= 1 if item.sell_in > 0
  end

  def update_quality()
    @items.each do |item|
      check_type(item)
    end
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