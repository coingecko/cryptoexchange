module Cryptoexchange::Exchanges
  module Bitsten
    class Market < Cryptoexchange::Models::Market
      NAME = 'bitsten'
      API_URL = 'https://bitsten.com/api/v1'

      def self.trade_page_url(args={})
        "https://bitsten.com/exchange/#{args[:base].downcase}_#{args[:target].downcase}"
      end
    end
  end
end
