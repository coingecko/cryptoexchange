module Cryptoexchange::Exchanges
  module Singularx
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Singularx::Market::API_URL}/v1/Ticker"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output.map do |pair, _ticker|
            target, base = pair.split('_')
            Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Singularx::Market::NAME
            )
          end
        end
      end
    end
  end
end
