require './lib/assets/hateburate-rss'
require './lib/assets/hateburate-mecab'

module Tasks
  class Crawler
    NEWS_URI = 'http://b.hatena.ne.jp/entrylist?sort=hot&threshold=3&mode=rss'
    def self.execute
      status = CrawlStatus.all.first
      date = status ? status.date : Time.local(2013,1,1)

      items = HatebuRate::RSS.new.items
      items.each do |item|
        feed = Feed.new(:title => item.title, :url => item.link, :date => item.date )
        if item.date <= date
          next
        end

        feed.save 
        puts item.title
        
        point = count(HatebuRate::Mecab.new.parse(item.title))
        catalog = Catalog.new(:point => point, :done => false)
        catalog.feed = feed
        catalog.save
      end

      status = CrawlStatus.new unless status 
      status.date = items[0].date
      status.save
    end

    private
    def self.count(surfaces)
      point = 0
      surfaces.each do |w|
        rank = Rank.where(:word => w).first
        point += rank.point if rank
      end
      point
    end
  end
end

