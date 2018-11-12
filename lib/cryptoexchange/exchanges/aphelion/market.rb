module Cryptoexchange::Exchanges
  module Aphelion
    class Market < Cryptoexchange::Models::Market
      NAME = 'aphelion'
      API_URL = 'http://mainnet.aphelion-neo.com:62433/api'

      def self.trade_page_url(args={})
        "http://mainnet.aphelion-neo.com"
      end
    end
  end
end
