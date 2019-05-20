module Cryptoexchange::Exchanges
  module Bitasset
    class Market < Cryptoexchange::Models::Market
      NAME = 'bitasset'
      API_URL = 'https://api.bitasset.com/api/v1'

      def self.trade_page_url(args={})
        "https://www.bitasset.com/ktrade/#{args[:base]}-#{args[:target]}"
      end
    end
  end
end
