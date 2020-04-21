require 'gilded_rose'

describe GildedRose do

  describe "#update_quality" do
    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "foo"
    end

    it "increases the quality of 'Aged Brie" do
      items = [Item.new("Aged Brie", 1, 1)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 2
    end

    it "decreases the quality of normal item" do
      items = [Item.new("The Complete Works of Ronald McDonald", 1, 1)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 0
    end

    it "'Sulfuras, Hand of Ragnaros' does not decrease in quality" do
      items = [Item.new("Sulfuras, Hand of Ragnaros", 1, 10)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 10
    end

    it "'Sulfuras, Hand of Ragnaros' does not decrease sell in number" do
      items = [Item.new("Sulfuras, Hand of Ragnaros", 1, 10)]
      GildedRose.new(items).update_quality()
      expect(items[0].sell_in).to eq 1
    end

    it "quality doesn't fall below 0" do
      items = [Item.new("Egg Sandwiches", 1, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 0
    end

    it "quality doesn't rise above 50" do
      items = [Item.new("Aged Brie", 20, 50)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 50
    end

    it "quality degrades twice as fast when sell in is 0" do
      items = [Item.new("Haunted Toenail Clippings", 0, 50)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 48
    end

    context 'Backstage passes to a TAFKAL80ETC concert' do

      it "increases the quality by 3 of 'Backstage passes to a TAFKAL80ETC concert' when there are 5 days or less left to sell" do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 1, 1)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 4
      end

      it "increases the quality by 2 of 'Backstage passes to a TAFKAL80ETC concert' when there are 10 days or less left to sell" do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 9, 1)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 3
      end

      it "quality is 0 for 'Backstage passes to a TAFKAL80ETC concert' when there are 0 days left to sell" do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 0, 1)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 0
      end

    end
    

  end



end
