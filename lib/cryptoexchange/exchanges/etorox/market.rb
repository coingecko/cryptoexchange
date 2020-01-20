module Cryptoexchange::Exchanges
  module Etorox
    class Market < Cryptoexchange::Models::Market
      NAME = 'etorox'
      API_URL = 'https://services.etorox.com/api/v1/marketdata'

      def self.trade_page_url(args={})
        "https://www.etorox.com/exchange/#{args[:base].downcase}-#{args[:target].downcase}"
      end
    end
  end
end
