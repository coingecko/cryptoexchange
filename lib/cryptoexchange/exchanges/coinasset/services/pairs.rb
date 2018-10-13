module Cryptoexchange::Exchanges
  module Coinasset
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Coinasset::Market::API_URL}/tickers"

        def fetch
          output = super
          market_pairs = []
          output.each do |pair|
            base, target = pair[1]['symbol'].split('-')
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: base,
                              target: target,
                              market: Coinasset::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
