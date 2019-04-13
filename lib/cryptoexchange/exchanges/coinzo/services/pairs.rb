module Cryptoexchange::Exchanges
  module Coinzo
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Coinzo::Market::API_URL}/tickers"

        def fetch
          output = super
          market_pairs = []
          output.each do |pair|
            base, target = pair[0].split('-')
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: base,
                              target: target,
                              market: Coinzo::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
