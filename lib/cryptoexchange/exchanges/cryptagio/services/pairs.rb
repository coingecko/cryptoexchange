module Cryptoexchange::Exchanges
  module Cryptagio
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Cryptagio::Market::API_URL}/markets"

        def fetch
          output = super
          market_pairs = []
          output.each do |pair|
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: pair['base_unit'].upcase,
                              target: pair['quote_unit'].upcase,
                              market: Cryptagio::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
