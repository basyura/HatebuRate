
class RssItem
  attr_reader :title, :url, :date, :point, :surfaces
  def initialize(catalog)
    @catalog  = catalog
    @title    = @catalog.feed.title
    @url      = @catalog.feed.url
    @date     = @catalog.feed.date
    @surfaces = HatebuRate::Mecab.new.parse(@catalog.feed.title)
    @point    = @catalog.point
  end
end
