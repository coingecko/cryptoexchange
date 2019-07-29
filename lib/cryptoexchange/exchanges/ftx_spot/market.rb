module Cryptoexchange::Exchanges
  module FtxSpot
    class Market < Cryptoexchange::Models::Market
      NAME = 'ftx_spot'
      API_URL = 'https://ftx.com/api'

      def self.trade_page_url(args={})
        "https://ftx.com/trade/#{args[:base]}/#{args[:target]}"
      end
    end
  end
end
