module Cryptoexchange::Exchanges
  module Bitsdaq
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Bitsdaq::Market::API_URL}/normal/dg/marketSummary24h/detail"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          pairs = output
          market_pairs = []
          pairs.each do |pair|
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: pair['symbol'],
                              target: pair['anchor'],
                              market: Bitsdaq::Market::NAME
                            )
          end

          market_pairs
        end
      end
    end
  end
end
