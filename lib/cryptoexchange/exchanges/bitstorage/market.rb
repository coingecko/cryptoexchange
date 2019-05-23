module Cryptoexchange::Exchanges
  module Bitstorage
    class Market < Cryptoexchange::Models::Market
      NAME = 'bitstorage'
      API_URL = 'https://bitstorage.finance/api'

      def self.trade_page_url(args={})
        "https://bitstorage.finance/market/#{args[:base]}-#{args[:target]}"
      end
    end
  end
end
