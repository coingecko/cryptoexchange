module Cryptoexchange::Exchanges
  module BiboxFutures
    class Market < Cryptoexchange::Models::Market
      NAME = 'bibox_futures'
      API_URL = 'https://api.bibox.com/v1'

      def self.trade_page_url(args={})
        "https://www.bibox.com/contract?coinPair=#{args[:inst_id]}"
      end
    end
  end
end
