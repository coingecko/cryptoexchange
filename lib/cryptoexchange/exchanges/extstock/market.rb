module Cryptoexchange::Exchanges
  module Extstock
    class Market < Cryptoexchange::Models::Market
      NAME = 'extstock'
      API_URL = 'https://extstock.com/api/v1'

      def self.trade_page_url(args={})
        "https://extstock.com/markets/#{args[:base]}_#{args[:target]}"
      end
    end
  end
end
