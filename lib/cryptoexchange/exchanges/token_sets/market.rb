module Cryptoexchange::Exchanges
  module TokenSets
    class Market < Cryptoexchange::Models::Market
      NAME = 'token_sets'
      API_URL = "https://api.tokensets.com/v1"

      def self.trade_page_url(args={})
        "https://www.tokensets.com/set/#{args[:inst_id]}"
      end
    end
  end
end
