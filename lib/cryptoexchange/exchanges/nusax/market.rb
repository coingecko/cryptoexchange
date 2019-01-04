module Cryptoexchange::Exchanges
  module Nusax
    class Market < Cryptoexchange::Models::Market
      NAME = 'nusax'
      API_URL = 'https://nusax.co.id/api/v2'

      def self.trade_page_url(args={})
        "https://nusax.co.id/trading/#{args[:base]}#{args[:target]}"
      end
    end
  end
end
