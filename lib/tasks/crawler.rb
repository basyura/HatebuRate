require './lib/assets/hateburate-rss'

module Tasks
  class Crawler
    NEWS_URI = 'http://b.hatena.ne.jp/entrylist?sort=hot&threshold=3&mode=rss'
    def self.execute
      status = CrawlStatus.all.first
      date = status ? status.date : Time.local(2013,1,1)

      items = HatebuRate::RSS.new.items
      items.each do |item|
        feed = Feed.new(:title => item.title, :url => item.link, :date => item.date )
        if item.date > date
          feed.save 
          puts item.title
        end
      end

      status = CrawlStatus.new unless status 
      status.date = items[0].date
      status.save
    end
  end
end

