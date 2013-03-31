require 'open-uri'
require 'rss'

module HatebuRate
  class RSS
    NEWS_URI = 'http://b.hatena.ne.jp/entrylist?sort=hot&threshold=3&mode=rss'
    def items
      rss = ::RSS::Parser.parse(open(NEWS_URI, &:read))
      rss.items.each do |item|
        puts item.title
        puts item.link
      end
    end
  end
end

HatebuRate::RSS.new.items
