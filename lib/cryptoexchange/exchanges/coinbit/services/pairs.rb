module Cryptoexchange::Exchanges
  module Coinbit
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Coinbit::Market::API_URL}"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          pairs = output
          market_pairs = []
          pairs.each do |pair|
            target, base = pair[0].split('_')
            market_pairs <<
            Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Coinbit::Market::NAME
            )
          end
          market_pairs
        end
      end
    end
  end
end
