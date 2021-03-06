require_relative './constants'
require_relative './aged_brie'
require_relative './backstage_passes'

class UpdateQuality

  include Constants

  def initialize(item)
    @item = item
  end

  def determine_quality_change
    if aged_brie?(@item)
      AgedBrie.new(@item.quality, @item.sell_in).determine_quality_change
    elsif backstage_passes?(@item)
      BackstagePasses.new(@item.quality, @item.sell_in).determine_quality_change
    else
      reduce_quality(@item.quality)
    end
  end

  def reduce_quality(item_quality)
    if item_quality.negative?
      item_quality - REDUCE_DOUBLE
    else
      item_quality.between?(1, 50) ? item_quality - REDUCE_NORMAL : item_quality
    end
  end

  def aged_brie?(item)
    item.name == "Aged Brie"
  end

  def backstage_passes?(item)
    item.name == "Backstage passes to a TAFKAL80ETC concert"
  end
end
