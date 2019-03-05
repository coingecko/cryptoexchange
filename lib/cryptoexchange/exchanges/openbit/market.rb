module Cryptoexchange::Exchanges
  module Openbit
    class Market < Cryptoexchange::Models::Market
      NAME = 'openbit'
      API_URL = 'https://market.openbit.online'

      def self.trade_page_url(args={})
        "https://market.openbit.online/trade/index/market/#{args[:base].downcase}_#{args[:target].downcase}"
      end
    end
  end
end
