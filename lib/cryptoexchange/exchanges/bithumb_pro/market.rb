module Cryptoexchange::Exchanges
  module BithumbGlobal
    class Market < Cryptoexchange::Models::Market
      NAME = 'bithumb_global'
      API_URL = 'https://global-openapi.bithumb.pro/openapi/v1'

      def self.trade_page_url(args={})
        "https://global.bithumb.pro/spot/trade;symbol=#{args[:base]}_#{args[:target]}"
      end
    end
  end
end
