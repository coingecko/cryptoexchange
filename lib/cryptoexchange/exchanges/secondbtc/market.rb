module Cryptoexchange::Exchanges
  module Secondbtc
    class Market < Cryptoexchange::Models::Market
      NAME = 'secondbtc'
      API_URL = 'https://secondbtc.com/api'

      def self.trade_page_url(args={})
        "https://secondbtc.com/exchange/#{args[:target]}-#{args[:base]}"
      end
    end
  end
end
