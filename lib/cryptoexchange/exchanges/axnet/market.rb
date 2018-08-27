module Cryptoexchange::Exchanges
  module Axnet
    class Market < Cryptoexchange::Models::Market
      NAME = 'axnet'
      API_URL = 'https://ax.net/api'

      def self.trade_page_url(args={})
        "https://dex.ax.net/#{args[:base]}_#{args[:target]}"
        # "http://52.52.32.26/#{args[:base]}_#{args[:target]}"
      end
    end
  end
end
