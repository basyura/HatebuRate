require 'hateburate-rss'
require 'hateburate-mecab'

class HomeController < ApplicationController
  RSS_HATEBU_NEWS = 'http://b.hatena.ne.jp/entrylist?sort=hot&threshold=3&mode=rss'
  def index
    @items = Catalog.where(:done => false).map.each{|catalog| RssItem.new(catalog) }.select{|item| item.point >= -10}.reverse
  end

  def up
    rank(1)
    render
  end

  def down
    rank(-1)
    render
  end

  private
  def rank(point)
    HatebuRate::Mecab.new.parse(params[:title]).each do |m|
      rank = Rank.where(:word => m).first
      unless rank
        rank = Rank.new(:word => m, :point => 0)
      end
      rank.point += point
      rank.save
    end
  end
end
