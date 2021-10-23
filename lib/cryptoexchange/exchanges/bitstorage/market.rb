module Cryptoexchange::Exchanges
  module Bitstorage
    class Market < Cryptoexchange::Models::Market
      NAME = 'bitstorage'
      API_URL = 'https://pub.bitstorage.finance/v2'

      def self.trade_page_url(args={})
        "https://bitstorage.finance/market/#{args[:base]}-#{args[:target]}"
      end
    end
  end
end
