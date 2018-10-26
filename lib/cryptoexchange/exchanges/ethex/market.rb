module Cryptoexchange::Exchanges
  module Ethex
    class Market < Cryptoexchange::Models::Market
      NAME = 'ethex'
      API_URL = 'https://api.ethex.market:5055'
      def self.trade_page_url(args={})
        "https://ethex.market/##{args[:target]}"
      end
    end
  end
end
