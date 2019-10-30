module Cryptoexchange::Exchanges
  module Bitfinex
    class Market < Cryptoexchange::Models::Market
      NAME = 'bitfinex'
      API_URL = 'https://api.bitfinex.com/v2'
      WS_URL = 'wss://api.bitfinex.com/ws/'

      def self.trade_page_url(args = {})
        "https://www.bitfinex.com/t/#{args[:base]}#{args[:target]}?refcode=6dwJVwfb"
      end
    end
  end
end
