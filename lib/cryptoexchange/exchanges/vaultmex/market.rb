module Cryptoexchange::Exchanges
  module Vaultmex
    class Market < Cryptoexchange::Models::Market
      NAME = 'vaultmex'
      API_URL = 'https://vaultmex.com/v1'

      def self.trade_page_url(args={})
        "https://vaultmex.com/trade/#{args[:base]}/#{args[:target]}"
      end
    end
  end
end
