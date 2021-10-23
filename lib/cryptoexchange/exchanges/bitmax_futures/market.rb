module Cryptoexchange::Exchanges
  module BitmaxFutures
    class Market < Cryptoexchange::Models::Market
      NAME = 'bitmax_futures'
      API_URL = 'https://bitmax.io/api/pro/v1'

      def self.trade_page_url(args={})
        "https://bitmax.io/#/futures/#{args[:inst_id].downcase}"
      end
    end
  end
end
