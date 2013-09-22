require './lib/assets/hateburate-rss'
require './lib/assets/hateburate-mecab'
require './lib/assets/hateburate-instapaper'

module Tasks
  class Crawler
    NEWS_URI = 'http://b.hatena.ne.jp/entrylist?sort=hot&threshold=3&mode=rss'
    def self.execute

      status = CrawlStatus.all.first
      date = status ? status.date : Time.local(2013,1,1)
      instapaper = HatebuRate::Instapaper.new

      items = HatebuRate::RSS.new.items
      items.each do |item|
        break if item.date <= date

        feed = Feed.new(:title => item.title, :url => item.link, :date => item.date )
        feed.save 

        point = count(HatebuRate::Mecab.new.parse(item.title))
        puts point.to_s + ' - ' + item.title

        sended = instapaper.add(point, item.link)
        puts 'send to instapaper ... ' if sended

        catalog = Catalog.new(point: point, done: false, sended: sended)
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

