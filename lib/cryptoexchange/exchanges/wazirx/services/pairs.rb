module Cryptoexchange::Exchanges
  module Wazirx
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Wazirx::Market::API_URL}/tickers"

        def fetch
          output = super
          market_pairs = []
          output.each do |pair|
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: pair[1]['base_unit'].upcase,
                              target: pair[1]['quote_unit'].upcase,
                              market: Wazirx::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
