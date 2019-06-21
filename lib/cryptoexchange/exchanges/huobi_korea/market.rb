module Cryptoexchange::Exchanges
  module HuobiKorea
    class Market < Cryptoexchange::Models::Market
      NAME = 'huobi_korea'
      API_URL = 'https://api-cloud.huobi.co.kr'

      def self.trade_page_url(args={})
        "https://www.huobi.co.kr/en-US/exchange/#{args[:base].downcase}_#{args[:target].downcase}/"
      end
    end
  end
end
