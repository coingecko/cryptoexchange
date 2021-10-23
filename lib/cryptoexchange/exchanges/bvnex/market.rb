module Cryptoexchange::Exchanges
  module Bvnex
    class Market < Cryptoexchange::Models::Market
      NAME = 'bvnex'
      API_URL = 'https://api.bvnex.com/api'

      def self.trade_page_url(args={})
        "https://www.bvnex.com/#/trade/#{args[:base].downcase}_#{args[:target].downcase}"
      end
    end
  end
end
