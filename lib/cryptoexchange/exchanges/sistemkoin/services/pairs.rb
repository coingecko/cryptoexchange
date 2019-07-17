module Cryptoexchange::Exchanges
  module Sistemkoin
    module Services
      class Pairs < Cryptoexchange::Services::Pairs

        PAIRS_URL = "#{Cryptoexchange::Exchanges::Sistemkoin::Market::API_URL}/ticker"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          market_pairs = []
          output.each do |target, pair|
            pair.each do |pair|
              market_pairs << Cryptoexchange::Models::MarketPair.new(
                                base: pair[0],
                                target: target,
                                market: Sistemkoin::Market::NAME)
            end
          end
          market_pairs
        end
      end
    end
  end
end
