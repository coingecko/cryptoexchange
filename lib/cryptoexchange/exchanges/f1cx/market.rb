module Cryptoexchange::Exchanges
  module F1cx
    class Market < Cryptoexchange::Models::Market
      NAME = 'f1cx'
      API_URL = 'https://f1cx.com/api/v2'

      def self.trade_page_url(args={})
        "https://f1cx.com/markets/#{args[:base]}#{args[:target]}"
      end
    end
  end
end
