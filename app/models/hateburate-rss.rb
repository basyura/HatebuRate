
module HatebuRate
  class RSS
    NEWS_URI = 'http://b.hatena.ne.jp/entrylist?sort=hot&threshold=3&mode=rss'
    def items
      rss = ::RSS::Parser.parse(open(NEWS_URI, &:read)).items
    end
  end
end
