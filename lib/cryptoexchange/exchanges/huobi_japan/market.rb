module Cryptoexchange::Exchanges
  module HuobiJapan
    class Market < Cryptoexchange::Models::Market
      NAME = 'huobi_japan'
      API_URL = 'https://api-cloud.huobi.co.jp'

      def self.trade_page_url(args={})
        "https://www.huobi.co.jp/exchange/#{args[:base].downcase}_#{args[:target].downcase}/"
      end
    end
  end
end
