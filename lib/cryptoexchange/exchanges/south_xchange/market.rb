module Cryptoexchange::Exchanges
  module SouthXchange
    class Market < Cryptoexchange::Models::Market
      NAME = 'south_xchange'
      API_URL = 'https://www.southxchange.com/api'

      def self.trade_page_url(args={})
        "https://www.southxchange.com/Market/Book/#{args[:base]}/#{args[:target]}"
      end
    end
  end
end
