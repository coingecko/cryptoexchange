module Cryptoexchange::Exchanges
  module BitboxPrivate
    class Market < Cryptoexchange::Models::Market
      NAME = 'bitbox_private'
      API_URL = 'https://openapi.bitbox.me'

      def self.trade_page_url(args={})
        "https://www.bitbox.me/exchange?coin=#{args[:base]}&market=#{args[:target]}"
      end
    end
  end
end
