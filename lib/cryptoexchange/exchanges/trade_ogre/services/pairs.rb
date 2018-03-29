module Cryptoexchange::Exchanges
  module  TradeOgre
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::TradeOgre::Market::API_URL}/markets"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output.collect do |pair|
            target, base = pair.keys.first.split("-")
            Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: TradeOgre::Market::NAME
            )
          end
        end
      end
    end
  end
end
