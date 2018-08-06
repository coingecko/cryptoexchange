module Cryptoexchange::Exchanges
  module Bcex
    class Market < Cryptoexchange::Models::Market
      NAME = 'bcex'
      API_URL = 'https://www.bcex.ca'

      def self.trade_page_url(args={})
        "https://www.bcex.ca/trade/#{args[:base]}2#{args[:target]}"
      end
    end
  end
end
