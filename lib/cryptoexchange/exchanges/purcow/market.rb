module Cryptoexchange::Exchanges
  module Purcow
    class Market < Cryptoexchange::Models::Market
      NAME = 'purcow'
      API_URL = 'https://www.purcow.io/api/v1'

      def self.trade_page_url(args={})
        "https://www.purcow.io/t/#{args[:base]}_#{args[:target]}"
      end
    end
  end
end
