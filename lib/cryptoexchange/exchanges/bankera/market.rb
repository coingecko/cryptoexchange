module Cryptoexchange::Exchanges
  module Bankera
    class Market < Cryptoexchange::Models::Market
      NAME = 'bankera'
      API_URL = 'https://api-exchange.bankera.com'

      def self.trade_page_url(args = {})
        "https://exchange.bankera.com/market/#{args[:base]}-#{args[:target]}"
      end
    end
  end
end
