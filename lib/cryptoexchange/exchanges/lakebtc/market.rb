module Cryptoexchange::Exchanges
  module Lakebtc
    class Market < Cryptoexchange::Models::Market
      NAME = 'lakebtc'
      API_URL = 'https://api.lakebtc.com/api_v2'

      def self.trade_page_url(args={})
        "https://www.lakebtc.com/deposits/new?currency=#{args[:target].downcase}"
      end
    end
  end
end
