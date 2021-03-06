require 'open-uri'
require 'rss'

module HatebuRate
  class RSS
    NEWS_URI = 'http://b.hatena.ne.jp/entrylist?sort=hot&threshold=3&mode=rss'
    def items
      rss = ::RSS::Parser.parse(open(NEWS_URI, &:read)).items
    end
  end
end

#if __FILE__ == $0
  #HatebuRate::RSS.new.items.each do |item|
    #puts item.title
    #puts item.link
    #puts ""
  #end
#end
