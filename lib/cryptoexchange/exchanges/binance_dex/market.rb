module Cryptoexchange::Exchanges
  module BinanceDex
    class Market < Cryptoexchange::Models::Market
      NAME = 'binance_dex'
      API_URL = 'https://testnet-dex.binance.org/api/v1'

      def self.trade_page_url(args={})
        "https://testnet.binance.org/trade/#{args[:base]}_#{args[:target]}"
      end
    end
  end
end
