module Cryptoexchange::Exchanges
  module Abcc
    class Market < Cryptoexchange::Models::Market
      NAME    = 'abcc'
      API_URL = 'https://api.abcc.com/api/v2'

      def self.trade_page_url(args={})
        "https://abcc.com/markets/#{args[:base]}#{args[:target]}"
      end
    end
  end
end
