module Cryptoexchange::Exchanges
  module Bibox
    class Market < Cryptoexchange::Models::Market
      NAME = 'bibox'
      API_URL = 'https://api.bibox.com/v1'

      def self.trade_page_url(args={})
        "https://www.bibox.com/exchange?coinPair=#{args[:base]}_#{args[:target]}"
      end
    end
  end
end
