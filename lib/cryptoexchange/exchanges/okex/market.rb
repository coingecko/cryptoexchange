module Cryptoexchange::Exchanges
  module Okex
    class Market < Cryptoexchange::Models::Market
      NAME = 'okex'
      API_URL = 'https://www.okex.com/api/v1'

      def self.trade_page_url(args={})
        "https://www.okex.com/market?product=#{args[:base].downcase}_#{args[:target].downcase}"
      end
    end
  end
end
