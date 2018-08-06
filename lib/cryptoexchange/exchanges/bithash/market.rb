module Cryptoexchange::Exchanges
  module Bithash
    class Market < Cryptoexchange::Models::Market
      NAME = 'bithash'
      API_URL = 'https://www.bithash.net/api'

      def self.trade_page_url(args={})
        "https://www.bithash.net/en/trade/#{args[:base]}/#{args[:target]}"
      end
    end
  end
end
