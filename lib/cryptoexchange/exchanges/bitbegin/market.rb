module Cryptoexchange::Exchanges
  module Bitbegin
    class Market < Cryptoexchange::Models::Market
      NAME = 'bitbegin'
      API_URL = 'https://bitbegin.io/api'

      def self.trade_page_url(args={})
        "https://bitbegin.io/trade?PairName=#{args[:base]}-#{args[:target]}"
      end
    end
  end
end
