module Cryptoexchange::Exchanges
  module Cryptonit
    class Market < Cryptoexchange::Models::Market
      NAME = 'cryptonit'
      API_URL = 'https://api.cryptonit.net/api'

      def self.trade_page_url(args={})
        "https://www.cryptonit.net/en/exchange?pair=#{args[:base]}-#{args[:target]}"
      end
    end
  end
end
