module Cryptoexchange::Exchanges
  module Bitbox
    class Market < Cryptoexchange::Models::Market
      NAME = 'bitbox'
      API_URL = 'https://api.bitbox.me/trade/public/v2'

      def self.trade_page_url(args={})
        "https://www.bitbox.me/exchange?coin=#{args[:base]}&market=#{args[:target]}"
      end
    end
  end
end
