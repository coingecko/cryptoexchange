module Cryptoexchange::Exchanges
  module Vertpig
    class Market < Cryptoexchange::Models::Market
      NAME = 'vertpig'
      API_URL = 'https://www.vertpig.com/api/v1.1'

      def self.trade_page_url(args={})
        "https://www.vertpig.com/exchange/#{args[:base]}#{args[:target]}"
      end
    end
  end
end
