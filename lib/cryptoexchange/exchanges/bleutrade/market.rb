module Cryptoexchange::Exchanges
  module Bleutrade
    class Market < Cryptoexchange::Models::Market
      NAME = 'bleutrade'
      API_URL = 'https://bleutrade.com/api/v2'

      def self.trade_page_url(args={})
        "https://bleutrade.com/en/trade/basic/#{args[:base].upcase}/#{args[:target].upcase}"
      end
    end
  end
end
