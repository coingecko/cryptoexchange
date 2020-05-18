module Cryptoexchange::Exchanges
  module BithumbFutures
    class Market < Cryptoexchange::Models::Market
      NAME = 'bithumb_futures'
      API_URL = 'https://bithumbfutures.com/api/pro/v1'

      def self.trade_page_url(args={})
        "https://bithumbfutures.com/#/futures/#{args[:inst_id].downcase}"
      end
    end
  end
end
