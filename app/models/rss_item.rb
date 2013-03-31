
class RssItem
  def initialize(item)
    @item     = item
    @surfaces = HatebuRate::Mecab.new.parse(item.title)
  end

  def title
    @item.title
  end

  def link
    @item.link
  end

  def surfaces
    @surfaces
  end
end
