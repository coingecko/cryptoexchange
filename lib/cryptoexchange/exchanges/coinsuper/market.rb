module Cryptoexchange::Exchanges
  module Coinsuper
    class Market < Cryptoexchange::Models::Market
      NAME = 'coinsuper'
      API_URL = 'https://www.coinsuper.com/v1/api'

      def self.trade_page_url(args={})
        "https://www.coinsuper.com/trade?symbol=#{args[:base]}%2F#{args[:target]}"
      end
    end
  end
end
