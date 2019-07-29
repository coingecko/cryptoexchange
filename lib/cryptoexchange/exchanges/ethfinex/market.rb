module Cryptoexchange::Exchanges
  module Ethfinex
    class Market < Cryptoexchange::Models::Market
      NAME = 'ethfinex'
      API_URL = 'https://api-pub.ethfinex.com'

      def self.trade_page_url(args={})
        "https://ethfinex.com"
      end
    end
  end
end
