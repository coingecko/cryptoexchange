module Cryptoexchange::Exchanges
  module Raidofinance
    class Market < Cryptoexchange::Models::Market
      NAME = 'raidofinance'
      API_URL = 'https://datacenter.raidofinance.eu/v1'

      def self.trade_page_url(args={})
        "https://raidofinance.eu/exchange/#{args[:base]}#{args[:target]}"
      end
    end
  end
end
