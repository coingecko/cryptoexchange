module Cryptoexchange::Exchanges
  module CompoundFinance
    class Market < Cryptoexchange::Models::Market
      NAME = 'compound_finance'
      API_URL = 'https://api.compound.finance/api/v2'

      def self.trade_page_url(args={})
        "https://app.compound.finance"
      end
    end
  end
end
