module Cryptoexchange::Exchanges
  module Bitebtc
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Bitebtc::Market::API_URL}/market"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output['result'].map do |pair|
            base, target = pair['market'].split('_')
            Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Bitebtc::Market::NAME
            )
          end
        end
      end
    end
  end
end
