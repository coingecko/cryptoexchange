module Cryptoexchange::Exchanges
  module Gate
    class Market < Cryptoexchange::Models::Market
      NAME = 'gate'
      API_URL = 'http://data.gate.io/api2/1'

      def self.trade_page_url(args={})
        "https://gate.io/trade/#{args[:base]}_#{args[:target]}"
      end
    end
  end
end
