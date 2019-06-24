module Cryptoexchange::Exchanges
  module Bithash
    class Market < Cryptoexchange::Models::Market
      NAME = 'bithash'
      API_URL = 'https://www.bithash.net/api'

      def self.trade_page_url(args={})
        "https://www.bithash.net/en/exchange/#{args[:base].downcase}/#{args[:target].downcase}"
      end
    end
  end
end
