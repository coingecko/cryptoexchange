module Cryptoexchange::Exchanges
  module BitsharesAssets
    class Market < Cryptoexchange::Models::Market
      NAME = 'bitshares_assets'
      API_URL = 'https://cryptofresh.com/api'

      def self.trade_page_url(args = {})
        base   = args[:base]
        target = args[:target]
        "https://openledger.io/market/#{base}_#{target}"
      end
    end
  end
end
