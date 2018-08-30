module Cryptoexchange::Exchanges
  module Cobinhood
    class Market < Cryptoexchange::Models::Market
      NAME = 'cobinhood'
      API_URL = 'https://api.cobinhood.com/v1'

      def self.trade_page_url(args={})
        "https://cobinhood.com/trade/#{args[:base]}-#{args[:target]}"
      end
    end
  end
end
