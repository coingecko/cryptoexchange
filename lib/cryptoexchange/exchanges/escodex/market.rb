module Cryptoexchange::Exchanges
  module Escodex
    class Market
      NAME = 'escodex'
      API_URL = 'http://labs.escodex.com/api'

      def self.trade_page_url(args={})
        "https://wallet.escodex.com/market/ESCODEX.#{args[:base]}_ESCODEX.#{args[:target]}"
      end
    end
  end
end
