require 'gilded_rose'

describe GildedRose do

  describe "#update_quality" do
    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "foo"
    end

    it "decreases the quality of normal item" do
      items = [Item.new("The Complete Works of Ronald McDonald", rand(1..100), rand(1..50))]
      expect{GildedRose.new(items).update_quality()}.to change{items[0].quality}.by(-1)
    end

    it "quality doesn't fall below 0" do
      items = [Item.new("Egg Sandwiches", rand(1..100), 0)]
      expect{GildedRose.new(items).update_quality()}.to change{items[0].quality}.by(0)
    end

    it "quality doesn't rise above 50" do
      items = [Item.new("Aged Brie", rand(1..100), 50)]
      expect{GildedRose.new(items).update_quality()}.to change{items[0].quality}.by(0)
    end

    it "quality degrades twice as fast when sell in is 0" do
      items = [Item.new("Haunted Toenail Clippings", 0, rand(2..50))]
      expect{GildedRose.new(items).update_quality()}.to change{items[0].quality}.by(-2)
    end

  
    context 'Aged Brie' do
      it "increases the quality of 'Aged Brie'" do
        items = [Item.new("Aged Brie", rand(1..100), rand(1..49))]
        expect{GildedRose.new(items).update_quality()}.to change{items[0].quality}.by(1)
      end
    end

    
    context 'Sulfuras, Hand of Ragnaros' do
      it "'Sulfuras, Hand of Ragnaros' does not decrease in quality" do
        items = [Item.new("Sulfuras, Hand of Ragnaros", rand(1..100), rand(1..50))]
        expect{GildedRose.new(items).update_quality()}.to change{items[0].quality}.by(0)
      end
  
      it "'Sulfuras, Hand of Ragnaros' does not decrease sell in number" do
        items = [Item.new("Sulfuras, Hand of Ragnaros", rand(1..100), rand(1..50))]
        expect{GildedRose.new(items).update_quality()}.to change{items[0].sell_in}.by(0)
      end
    end
 
    context 'Backstage passes to a TAFKAL80ETC concert' do
   
      it "increases the quality by 3 of 'Backstage passes to a TAFKAL80ETC concert' when there are 5 days or less left to sell" do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", rand(1..5), rand(1..47))]
        expect{GildedRose.new(items).update_quality()}.to change{items[0].quality}.by(3)
      end
    
      it "increases the quality by 2 of 'Backstage passes to a TAFKAL80ETC concert' when there are 10 days or less left to sell" do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", rand(6..10), rand(1..48))]
        expect{GildedRose.new(items).update_quality()}.to change{items[0].quality}.by(2)
      end
     
      it "quality is 0 for 'Backstage passes to a TAFKAL80ETC concert' when there are 0 days left to sell" do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 0, rand(1..50))]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 0
      end

    end

    context 'Conjured items' do
      #sell > 0, quality 2-50
      it 'quality degrates by 2' do
        items = [Item.new("Conjured Raddish", rand(1..100), rand(2..50))]
        expect{GildedRose.new(items).update_quality()}.to change{items[0].quality}.by(-2)
      end
      #sell  0, quality > 4
      it 'quality degrates by 4 when sell in date is 0' do
        items = [Item.new("Conjured Raddish", 0, rand(4..50))]
        expect{GildedRose.new(items).update_quality()}.to change{items[0].quality}.by(-4)
      end
    end
    

  end



end
