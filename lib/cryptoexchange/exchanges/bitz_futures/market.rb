module Cryptoexchange::Exchanges
  module BitzFutures
    class Market < Cryptoexchange::Models::Market
      NAME = 'bitz_futures'
      API_URL = "https://apiv2.bitz.com".freeze

      def self.trade_page_url(args={})
        "https://swap.bit-z.com/trade/#{args[:inst_id]}"
      end
    end
  end
end
