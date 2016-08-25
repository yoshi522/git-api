require 'bundler/setup'
require 'sinatra'
require 'json'


ENDPOINT_VERSION = 'v1'
BASIC_ENDPOINT = '/' + ENDPOINT_VERSION + '/'

get '/' do
  code = "Working normally: Time is <%= Time.now %> now."
  erb code
end

get '/' + ENDPOINT_VERSION do
  version = 'gif api version is 1.0'
  erb version
end

# GIF ENDPOINT
get BASIC_ENDPOINT + 'gif' do
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

get BASIC_ENDPOINT + 'gif/preview' do
  num = rand(8) + 1
  @gif_url = 'https://s3-ap-northeast-1.amazonaws.com/line-bot-2016/gif/git-' + num.to_s + '.gif'
  erb :preview
end


# IMAGE ENDPOINT
get BASIC_ENDPOINT + 'img' do
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

get BASIC_ENDPOINT + 'img/preview' do
  num = rand(8) + 1
  @img_url = 'https://s3-ap-northeast-1.amazonaws.com/line-bot-2016/img/img-' + num.to_s + '.jpeg'
  erb :img_preview
end


# GAL CONVERTER ENDPOINT
get BASIC_ENDPOINT + 'gal/text=:text' do # TODO: THIS URL ENDPOINT IS NOT GOOD PRACTICE, USE /v1/gal?text=:text

  # CONVERTER DICTIONARY
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

  arr = params[:text].split("")
  # INITIALISE
  resp = []
  # CONVERT TO GAL SENTENCE
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

  resp_gal = resp.join("")
  response = {
      meta: {
          status: 200
      },
      data: {
          content: resp_gal
      }
  }
  # RETURN JSON DATA
  response.to_json
end