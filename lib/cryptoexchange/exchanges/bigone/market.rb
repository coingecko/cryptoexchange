module Cryptoexchange::Exchanges
  module Bigone
    class Market < Cryptoexchange::Models::Market
      NAME = 'bigone'
      API_URL = 'https://big.one/api/v3'

      def self.trade_page_url(args={})
        "https://big.one/trade/#{args[:base]}-#{args[:target]}"
      end
    end
  end
end
