module Cryptoexchange::Exchanges
  module Veridex
    class Market < Cryptoexchange::Models::Market
      NAME = 'veridex'
      API_URL = 'https://dex-backend.verisafe.io/v2'

      def self.trade_page_url(args={})
        "https://dex.verisafe.io/#/erc20/?base=#{args[:base]}&quote=#{args[:target]}"
      end
    end
  end
end
