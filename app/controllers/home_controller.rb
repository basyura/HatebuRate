require 'hateburate-rss'
require 'hateburate-mecab'

class HomeController < ApplicationController
  RSS_HATEBU_NEWS = 'http://b.hatena.ne.jp/entrylist?sort=hot&threshold=3&mode=rss'
  def index
    @items = Catalog.where(:done => false).where("point >= ? ", -10).order("point desc, created_at").
                     map.each{|catalog| RssItem.new(catalog) }
  end

  def up
    rank(1, params[:title])
    Catalog.update(params[:id], :done => true)
    @id = params[:id]
    render
  end

  def down
    rank(-1, params[:title])
    Catalog.update(params[:id], :done => true)
    @id = params[:id]
    render
  end

  def done
    params[:done_list].split(",").each do |id|
      Catalog.update(id, :done => true)
    end
    redirect_to :root
  end

  private
  def rank(point, title)
    HatebuRate::Mecab.new.parse(title).each do |m|
      rank = Rank.where(:word => m).first
      unless rank
        rank = Rank.new(:word => m, :point => 0)
      end
      rank.point += point
      rank.save
    end
  end
end
