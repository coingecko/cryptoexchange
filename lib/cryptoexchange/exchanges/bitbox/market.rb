module Cryptoexchange::Exchanges
  module Bitbox
    class Market < Cryptoexchange::Models::Market
      NAME = 'bitbox'
      API_URL = 'https://openapi.bitfront.me/v1'

      def self.trade_page_url(args={})
        "https://www.bitfront.me/exchange/?coin=#{args[:base]}&market=#{args[:target]}"
      end
    end
  end
end
