module Cryptoexchange::Exchanges
  module Bitsoda
    class Market < Cryptoexchange::Models::Market
      NAME = 'bitsoda'
      API_URL = 'https://api.bitsoda.com/v1'

      def self.trade_page_url(args={})
        base = args[:base].upcase
        target = args[:target].upcase
        "https://bitsoda.com/trade/#{base}_#{target}"
      end
    end
  end
end
