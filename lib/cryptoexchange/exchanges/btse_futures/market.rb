module Cryptoexchange::Exchanges
  module BtseFutures
    class Market < Cryptoexchange::Models::Market
      NAME = 'btse_futures'
      API_URL = 'https://api.btse.com/futures/api/v1'

      def self.trade_page_url(args={})
        "https://www.btse.com/en/futures/#{args[:base]}PFC"
      end
    end
  end
end
