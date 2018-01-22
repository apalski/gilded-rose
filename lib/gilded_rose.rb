class GildedRose

  def initialize(items)
    @items = items
  end

  def past_sell_in_date?(item)
    item.sell_in < 0
  end

  def update_quality
    @items.each do |item|
      if item.valid_quality? && !past_sell_in_date?(item)
        if item.special_item?
          item.increase_quality
        else
          item.decrease_quality
        end

        if item.name == "Backstage passes to a TAFKAL80ETC concert"
          item.quality += 2
          if item.sell_in < 11
            item.increase_quality
          end
          if item.sell_in < 6
            item.increase_quality
          end
        end

        if item.name != "Sulfuras, Hand of Ragnaros"
          item.sell_in -= 1
        end
      end

      if item.valid_quality? && past_sell_in_date?(item)
        if item.special_item?
          item.increase_quality
        elsif item.name == "Backstage passes to a TAFKAL80ETC concert"
          item.quality = 0
        else
          item.decrease_quality
        end
      end
    end
  end
end

class Item

  attr_reader :name
  attr_accessor :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def special_item?
    ["Aged Brie",
      "Sulfuras, Hand of Ragnaros",
    ].include?(name)
  end

  def valid_quality?
    (0...50).include?(quality)
  end

  def increase_quality
    self.quality += 1
  end

  def decrease_quality
    self.quality -= 1
  end
end
# Items = [
#   Item.new("+5 Dexterity Vest", 10, 20),
#   Item.new("Aged Brie", 2, 0),
#   Item.new("Elixir of the Mongoose", 5, 7),
#   Item.new("Sulfuras, Hand of Ragnaros", 0, 80),
#   Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 20),
#   Item.new("Conjured Mana Cake", 3, 6),
# ]
