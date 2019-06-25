module Cryptoexchange::Exchanges
  module Bitmesh
    class Market < Cryptoexchange::Models::Market
      NAME='bitmesh'
      API_URL = 'https://api.bitmesh.com/?api=market.ticker'

      def self.trade_page_url(args={})
        "https://bitmesh.com/exchange?market=#{args[:target].downcase}_#{args[:base].downcase}#/"
      end
    end
  end
end
