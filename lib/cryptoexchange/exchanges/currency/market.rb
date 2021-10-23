module Cryptoexchange::Exchanges
  module Currency
    class Market < Cryptoexchange::Models::Market
      NAME = 'currency'
      API_URL = 'https://marketcap.backend.currency.com'

      def self.trade_page_url(args={})
        "https://exchange.currency.com/#{args[:base].downcase}-to-#{args[:target].downcase}"
      end
    end
  end
end
