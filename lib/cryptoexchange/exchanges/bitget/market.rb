module Cryptoexchange::Exchanges
  module Bitget
    class Market < Cryptoexchange::Models::Market
      NAME = 'bitget'
      API_URL = 'https://api.bitget.cc/data/v1'

      def self.trade_page_url(args={})
        "https://www.bitget.io/en/trade/#{args[:base].downcase}_#{args[:target].downcase}/"
      end
    end
  end
end
