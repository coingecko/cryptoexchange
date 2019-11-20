module Cryptoexchange::Exchanges
  module Deversifi
    class Market < Cryptoexchange::Models::Market
      NAME = 'deversifi'
      API_URL = 'https://api.deversifi.com/v2'

      def self.trade_page_url(args = {})
        "https://trustless.ethfinex.com/#{args[:base]}#{args[:target]}"
      end
    end
  end
end
