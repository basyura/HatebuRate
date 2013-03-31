
class RssItem
  attr_reader :title, :link, :point, :surfaces
  def initialize(item)
    @item     = item
    @title    = @item.title
    @link     = @item.link
    @surfaces = HatebuRate::Mecab.new.parse(item.title)
    @point    = count(@surfaces)
  end

  private
  def count(surfaces)
    point = 0
    surfaces.each do |w|
      rank = Rank.where(:word => w).first
      point += rank.point if rank
    end
    point
  end
end
