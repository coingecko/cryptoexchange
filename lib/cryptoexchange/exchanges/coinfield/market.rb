module Cryptoexchange::Exchanges
  module Coinfield
    class Market < Cryptoexchange::Models::Market
      NAME = 'coinfield'
      API_URL = 'https://api.coinfield.com/v1'

      def self.trade_page_url(args={})
        "https://trade.coinfield.com/pro/trade/#{args[:base]}-#{args[:target]}"
      end
    end
  end
end
