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
    elsif item.name.start_with?('Conjured')
      conjured(item)
    else
      regular(item)
    end
  end
#Logic for Aged Brie
  def brie(item)
    item.sell_in!=0 ? quality_plus_one(item) : quality_minus_two(item)
    sell_in_minus(item)
  end
#Logic for Backstage passes to a TAFKAL80ETC concert
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
 #Logic for Sulfuras, Hand of Ragnaros
  def sulfuras(item)
  end
#Logic for regular items
  def regular(item)
    item.sell_in!=0 ? quality_minus_one(item) : quality_minus_two(item)
    sell_in_minus(item)
  end
#Logic for Conjured items
  def conjured(item)
    item.sell_in!=0 ? quality_minus_two(item) : quality_minus_four(item)
    sell_in_minus(item)
  end

#------Update Item Properties------
  def quality_plus_one(item)
    item.quality += 1 if item.quality < 50
  end

  def quality_plus_two(item)
    if (item.quality + 2) > 50
      item.quality = 50
    else
      item.quality += 2
    end
  end

  def quality_plus_three(item)
    if (item.quality + 3) > 50
      item.quality = 50
    else
      item.quality += 3
    end
  end

  def quality_minus_one(item)
    item.quality -= 1 if item.quality > 0
  end

  def quality_minus_two(item)
    if (item.quality - 2) < 0
      item.quality = 0
    else
      item.quality -= 2
    end
  end

  def quality_minus_four(item)
    if (item.quality - 4) > 0
      item.quality == 0
    else
      item.quality -= 4
    end
  end

  def quality_zero(item)
    item.quality = 0
  end

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