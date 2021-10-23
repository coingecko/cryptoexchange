module Cryptoexchange::Exchanges
  module Cryptlocex
    class Market < Cryptoexchange::Models::Market
      NAME = 'cryptlocex'
      API_URL = 'https://trade.cryptlocex.com/Api'

      def self.trade_page_url(args={})
        "https://trade.cryptlocex.com/trade/index/market/#{args[:base].downcase}_#{args[:target].downcase}/"
      end
    end
  end
end
