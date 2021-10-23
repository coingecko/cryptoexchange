module Cryptoexchange::Exchanges
  module Vindax
    class Market < Cryptoexchange::Models::Market
      NAME='vindax'
      API_URL = 'https://api.vindax.com/api/v1'

      def self.trade_page_url(args={})
        "https://vindax.com/exchange-base.html?symbol=#{args[:base]}_#{args[:target]}"
      end
    end
  end
end
