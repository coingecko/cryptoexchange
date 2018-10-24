module Cryptoexchange::Exchanges
  module Axnet
    class Market < Cryptoexchange::Models::Market
      NAME = 'axnet'
      API_URL = 'https://ax.net/api'

      def self.trade_page_url(args={})
        "https://trade.ax.net/trade/#{args[:base]}_#{args[:target]}"
      end
    end
  end
end
