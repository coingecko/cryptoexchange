module Cryptoexchange::Exchanges
  module Nash
    class Market < Cryptoexchange::Models::Market
      NAME = 'nash'
      API_URL = 'https://app.nash.io/api'

      def self.trade_page_url(args={})
        "https://app.nash.io/trade/exchange/advanced?from=#{args[:base].downcase}&to=#{args[:target].downcase}"
      end
    end
  end
end
