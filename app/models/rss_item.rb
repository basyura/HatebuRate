
class RssItem
  attr_reader :id, :title, :url, :date, :point, :surfaces
  def initialize(catalog)
    @catalog  = catalog
    @id       = @catalog.id
    @title    = @catalog.feed.title
    @url      = @catalog.feed.url
    @date     = @catalog.feed.date
    @surfaces = HatebuRate::Mecab.new.parse(@catalog.feed.title)
    @point    = @catalog.point
    @sended   = @catalog.sended
  end

  def sended?
    @sended
  end

  def badge
    if @point > 5
      return 'badge-important'
    end

    if @point >= 0
      return 'badge-success'
    end

    if @point < -5
      return 'badge-inverse'
    end

    return 'badge-default'
  end
end
