module Cryptoexchange::Exchanges
  module Gbx
    class Market < Cryptoexchange::Models::Market
      NAME    = 'gbx'
      API_URL = 'https://exchange.gbx.gi/api/v1'

      def self.trade_page_url(args={})
        "https://exchange.gbx.gi/trade?symbol=#{args[:base]}%2F#{args[:target]}"
      end
    end
  end
end
