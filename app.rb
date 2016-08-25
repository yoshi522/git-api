require 'bundler/setup'
require 'sinatra'
require 'json'

get '/' do
  code = "Working normally: Time is <%= Time.now %> now."
  erb code
end

get '/v1' do
  version = 'gif api version is 1.0'
  erb version
end

get '/v1/gif' do
  num = rand(8) + 1
  @gif_url = 'https://s3-ap-northeast-1.amazonaws.com/line-bot-2016/gif/git-' + num.to_s + '.gif'
  response = {
    meta: {
        status: 200
    },
    data: {
        id: num,
        link: @gif_url
    }
  }
  response.to_json
end

get '/v1/gif/preview' do
  num = rand(8) + 1
  @gif_url = 'https://s3-ap-northeast-1.amazonaws.com/line-bot-2016/gif/git-' + num.to_s + '.gif'
  erb :preview
end

get '/v1/img' do
  num = rand(10) + 1
  @img_url = 'https://s3-ap-northeast-1.amazonaws.com/line-bot-2016/img/img-' + num.to_s + '.jpeg'
  response = {
      meta: {
          status: 200
      },
      data: {
          id: num,
          link: @img_url
      }
  }
  response.to_json
end

get '/v1/img/preview' do
  num = rand(8) + 1
  @img_url = 'https://s3-ap-northeast-1.amazonaws.com/line-bot-2016/img/img-' + num.to_s + '.jpeg'
  erb :img_preview
end

get '/v1/gal/text=:text' do
  galmap = {"あ" => "a", "い" => "i"} #hash
  sample = [] #init
  text = params[:text]
  arr = text.split("") # make a array based on text
  @arr = arr
  arr.each do |txt|
    galmap.each do |gal, value|
      if txt == gal
        txt = value
        sample.push(txt)
      elsif txt != gal
        sample.push(txt)
      end
    end
  end
  @sample = sample

  erb :gal
end

get '/v2/gal/text=:text' do
  galmap = {
      'あ' => "ぁ", 'い' => "ﾚヽ", 'う' => "ぅ", 'え' => "ぇ", 'お' => "ぉ",
      'か' => "ｶゝ", 'き' => "ｷ", 'く' => "＜", 'け' => "ﾚﾅ", 'こ' => "〓",
      'さ' => "､ﾅ", 'し' => "ι", 'す' => "￡", 'せ' => "世", 'そ' => "ξ",
      'た' => "ﾅﾆ", 'ち' => "干", 'つ' => "⊃", 'て' => "τ", 'と' => "ー⊂",
      'な' => "ﾅょ", 'に' => "ﾆ", 'ぬ' => "ゐ", 'ね' => "ね", 'の' => "＠",
      'は' => "￡", 'ひ' => "ひ", 'ふ' => "､ζ､", 'へ' => "∧", 'ほ' => "ﾚま",
      'ま' => "ま", 'み' => "彡", 'む' => "￡ヽ", 'め' => "×", 'も' => "м○",
      'や' => "ゃ", 'ゆ' => "ゅ", 'よ' => "ょ",
      'ら' => "ζ", 'り' => "L|", 'る' => "ゑ", 'れ' => "яё", 'ろ' => "з",
      'わ' => "ゎ", 'を' => "ぉ",'ん' => "ω",
      'が' => "ｶゞ", 'ぎ' => "ｷ″", 'ぐ' => "＜″", 'げ' => "ﾚﾅ″", 'ご' => "ご",
      'ざ' => "､ﾅ″", 'じ' => "ι″", 'ず' => "ず", 'ぜ' => "世″", 'ぞ' => "ξ″",
      'だ' => "ﾅﾆ″", 'ぢ' => "ち", 'づ' => "⊃″", 'で' => "τ″", 'ど' => "ー⊂″",
      'ば' => "l￡″", 'び' => "ひ″", 'ぶ' => "､ζ､″", 'べ' => "∧″", 'ぼ' => "ﾚま″",
      'ぱ' => "l￡°", 'ぴ' => "ひ°", 'ぷ' => "､ζ､°", 'ぺ' => "∧°", 'ぽ' => "ﾚま°",
      'ア' => "了", 'イ' => "ｨ", 'ウ' => "ｩ", 'エ' => "工", 'オ' => "才",
      'カ' => "ヵ", 'キ' => "≠", 'ク' => "勹", 'ケ' => "ヶ", 'コ' => "］",
      'サ' => "廾", 'シ' => "ﾞ/", 'ス' => "ｽ", 'セ' => "ｾ", 'ソ' => "｀／",
      'タ' => "勺", 'チ' => "于", 'ツ' => "\"/", 'テ' => "〒", 'ト' => "├",
      'ナ' => "ﾅ", 'ニ' => "二", 'ヌ' => "ﾇ", 'ネ' => "ﾈ", 'ノ' => "丿",
      'ハ' => "'`", 'ヒ' => "匕", 'フ' => "┐", 'ヘ' => "∧", 'ホ' => "朮",
      'マ' => "ﾏ", 'ミ' => "彡", 'ム' => "厶", 'メ' => "×", 'モ' => "ﾓ",
      'ヤ' => "ﾔ", 'ユ' => "ﾕ", 'ヨ' => "∋",
      'ラ' => "ﾗ", 'リ' => "└|", 'ル' => "｣ﾚ", 'レ' => "∠", 'ロ' => "□",
      'ワ' => "ﾜ", 'ヲ' => "ｦ",'ン' => "ﾝ",
      'ガ' => "ヵ″", 'ギ' => "≠″", 'グ' => "勹″", 'ゲ' => "ヶ″", 'ゴ' => "］″",
      'ザ' => "廾″", 'ジ' => "ﾞ/″", 'ズ' => "ｽ″", 'ゼ' => "ｾ″", 'ゾ' => "｀／″",
      'ダ' => "勺″", 'ヂ' => "于″", 'ヅ' => "\"/″", 'デ' => "〒″", 'ド' => "├″",
      'バ' => "ﾊ〃", 'ビ' => "ﾋ〃", 'ブ' => "ﾌ〃", 'ベ' => "∧″", 'ボ' => "朮″",
      'パ' => "ﾉヽ°", 'ピ' => "ｔ°", 'プ' => "ﾌo", 'ペ' => "∧°", 'ポ' => "朮°",
      'ー' => "→"
  }
  text = params[:text]
  arr = text.split("")
  resp = []
  if text != ""
    arr.map { |i|
      if /\p{Hiragana}/ =~ i || /\p{Katakana}/ =~ i
        galmap.each do |key, value|
          if i == key
            i = value
          elsif i != key then
          end
        end
        resp.push(i)
      else
        resp.push(i)
      end
    }
    response = resp.join("")
    response
  else
    response = {
        meta: {
            status: 200
        },
        data: {
            content: 'Invalid request'
        }
    }
    response.to_json
  end
end