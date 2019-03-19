module Cryptoexchange::Exchanges
  module Idax
    class Market < Cryptoexchange::Models::Market
      NAME = 'idax'
      API_URL = 'https://openapi.idax.pro/api/v2'

      def self.trade_page_url(args={})
        "https://www.idax.mn/#/exchange?pairname=#{args[:base]}_#{args[:target]}"
      end
    end
  end
end
