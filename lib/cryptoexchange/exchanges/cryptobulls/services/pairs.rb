module Cryptoexchange::Exchanges
  module Cryptobulls
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Cryptobulls::Market::API_URL}/ticker"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          hash = output.first # output looks like [hash]
          hash.collect do |pair, _ticker|
            target, base = pair.split("_")

            Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Cryptobulls::Market::NAME
            )
          end
        end
      end
    end
  end
end
