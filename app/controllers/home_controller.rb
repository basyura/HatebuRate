require 'hateburate_rss'

class HomeController < ApplicationController
  RSS_HATEBU_NEWS = 'http://b.hatena.ne.jp/entrylist?sort=hot&threshold=3&mode=rss'
  def index
    @items = HatebuRate::RSS.new.items
  end
end
