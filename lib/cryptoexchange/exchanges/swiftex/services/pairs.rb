module Cryptoexchange::Exchanges
  module Swiftex
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Swiftex::Market::API_URL}/tickers.json"

        def fetch
          output = super
          market_pairs = []
          output.each do |pair|
            base, target = pair[0].split('-')
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: base.upcase,
                              target: target.upcase,
                              market: Swiftex::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
