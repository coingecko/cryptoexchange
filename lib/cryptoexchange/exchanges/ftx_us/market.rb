module Cryptoexchange::Exchanges
  module FtxUs
    class Market < Cryptoexchange::Models::Market
      NAME = 'ftx_us'
      API_URL = 'https://ftx.us/api'

      def self.trade_page_url(args={})
        "https://ftx.us/trade/#{args[:base]}/#{args[:target]}"
      end
    end
  end
end
