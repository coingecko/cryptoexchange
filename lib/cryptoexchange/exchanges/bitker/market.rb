module Cryptoexchange::Exchanges
  module Bitker
    class Market < Cryptoexchange::Models::Market
      NAME = 'bitker'
      API_URL = 'https://third.bitker.com/v1/api'

      def self.trade_page_url(args={})
        "https://www.bitker.com/#/bbTrades/#{args[:base].downcase}_#{args[:target].downcase}"
      end
    end
  end
end
