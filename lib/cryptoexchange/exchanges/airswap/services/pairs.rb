module Cryptoexchange::Exchanges
  module Airswap
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Airswap::Market::API_URL}/ticker"
        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output.map do |pair|
            base, target = pair[0].split('_')
            Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Airswap::Market::NAME
            )
          end
        end
      end
    end
  end
end
