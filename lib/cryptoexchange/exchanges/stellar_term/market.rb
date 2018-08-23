module Cryptoexchange::Exchanges
  module StellarTerm
    class Market < Cryptoexchange::Models::Market
      NAME = "stellar_term".freeze
      API_URL = "https://api.stellarterm.com/v1".freeze

      def self.trade_page_url
        nil
      end
    end
  end
end
