module Cryptoexchange::Exchanges
  module Coinjar
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "https://api.exchange.coinjar.com/products"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          market_pairs = []
          output.collect do |pair|
            base, target = pair['name'].split('/')
            market_pairs << Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Coinjar::Market::NAME
            )
          end
          market_pairs
        end
      end
    end
  end
end
