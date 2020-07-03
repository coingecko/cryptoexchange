module Cryptoexchange::Exchanges
  module Ionomy
    class Market < Cryptoexchange::Models::Market
      NAME = 'ionomy'
      API_URL = 'https://ionomy.com/api/v1'

      def self.trade_page_url(args={})
        "https://ionomy.com/en/markets/#{args[:target]}-#{args[:base]}"
      end
    end
  end
end
