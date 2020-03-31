module Cryptoexchange::Exchanges
  module DexBlue
    class Market < Cryptoexchange::Models::Market
      NAME = 'dex_blue'
      API_URL = 'https://api.dex.blue/rest/v1'

      def self.trade_page_url(args={})
        "https://dex.blue/trading/##{args[:base]}/#{args[:target]}"
      end
    end
  end
end
