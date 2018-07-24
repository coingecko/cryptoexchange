module Cryptoexchange::Exchanges
  module Icoinbay
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Icoinbay::Market::API_URL}/v2/tickers"

        def fetch
          output = super
          market_pairs = []
          output.each do |pair|
            if pair[1]['isFrozen'] == "1"
            base, target = pair[0].split('_')
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: base,
                              target: target,
                              market: Icoinbay::Market::NAME
                            )
           end
          end
          market_pairs
        end
      end
    end
  end
end
