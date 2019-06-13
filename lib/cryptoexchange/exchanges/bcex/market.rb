module Cryptoexchange::Exchanges
  module Bcex
    class Market < Cryptoexchange::Models::Market
      NAME = 'bcex'
      API_URL = 'https://www.bcex.ca/api'

      def self.trade_page_url(args={})
        "https://www.bcex.ca/trade/#{args[:base].downcase}_#{args[:target].downcase}"
      end
    end
  end
end
