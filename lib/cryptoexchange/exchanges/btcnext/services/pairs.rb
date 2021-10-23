module Cryptoexchange::Exchanges
  module Btcnext
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Btcnext::Market::API_URL}/ticker"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          pairs = output.map do |pair, _ticker|
            base, target = pair.split("_")

            Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Btcnext::Market::NAME
            )
          end.compact
        end
      end
    end
  end
end
