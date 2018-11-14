module Cryptoexchange::Exchanges
  module Dcoin
    class Market < Cryptoexchange::Models::Market
      NAME = 'dcoin'
      API_URL = 'https://openapi.dcoin.com/api/v1'

      def self.trade_page_url(args={})
        "https://www.dcoin.com/currencyTrading/#{args[:base]}_#{args[:target]}"
      end
    end
  end
end
