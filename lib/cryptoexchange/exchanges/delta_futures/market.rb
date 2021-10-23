module Cryptoexchange::Exchanges
  module DeltaFutures
    class Market < Cryptoexchange::Models::Market
      NAME = 'delta_futures'
      API_URL = 'https://api.delta.exchange'

      def self.trade_page_url(args={})
        "https://www.delta.exchange/app/trade/#{args[:base]}/#{args[:inst_id]}"
      end
    end
  end
end
