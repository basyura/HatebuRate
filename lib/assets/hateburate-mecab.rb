require 'mecab/light'

module HatebuRate
  class Mecab
    def parse(text)
      text = filter(text)
      morphemes = MeCab::Light::Tagger.new.parse(text)
      morphemes.grep(proc {|m| m.surface.length != 1 && m.feature.split(',')[0] == '名詞' }) {|m| m.surface }
    end

    private
    def filter(text)
      list = text.split(/[-|:｜－]/)
      return list[0] if list.length == 1
      list[0].length > list[1].length ? list[0] : list[1]
    end
  end
end

if  __FILE__ == $0
  #text = 'この文を形態素解析してください。'
  #text = "Haskell の machines に入門してみた，というお話 - KrdLab's blog"
  #text = "子供が増えるとか減るとかの話 - ２４時間残念営業"
  #text = "【参考画像あり】うさぎ系彼女をイラストにした腐女子絵ワロタｗｗｗｗｗ | Ayu-Nya EXTRA"
  #text = "仕事も人生も思い通りにコントロールしたい人へ...「ウィークリーレビュー」のススメ : ライフハッカー［日本版］"
  #text = "ネットユーザー岡田ぱみゅぱみゅ（他）による「排外主義に対するメッセージ」新大久保街頭ビジョン広告 - Togetter"
  #text = "エアアジア・ジャパン 中部国際空港より、いよいよ就航！ 3月31日（日）名古屋（中部）－福岡線｜エアアジア・ジャパン株式会社のプレスリリース"
  #text = "週刊「孤独のトップバリュ グルメレポ」、第17回はふわふわの「とんかつ卵とじ風セット」 | め〜んずスタジオ"
  #text =  '「巨大なブラックバスの捕まえ方」に驚愕、そして"続き"に超驚愕 | DDN JAPAN'
  #text = "第四巻　富士山噴火～平安時代編～ | 地震予測検証 / 防災情報 Hazard Lab【ハザードラボ】"
  text = "VIPPERな俺 : スーパー銭湯があるってことは何処かにミラクル銭湯もあるの？"
  p HatebuRate::Mecab.new.parse(text)
end
