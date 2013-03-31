require 'hateburate-rss'
require 'hateburate-mecab'

class HomeController < ApplicationController
  RSS_HATEBU_NEWS = 'http://b.hatena.ne.jp/entrylist?sort=hot&threshold=3&mode=rss'
  def index
    @items = HatebuRate::RSS.new.items.map.each{|item| RssItem.new(item) }
  end
  def up
    puts params[:title]
    puts HatebuRate::Mecab.new.parse(params[:title])
    render
  end
end
