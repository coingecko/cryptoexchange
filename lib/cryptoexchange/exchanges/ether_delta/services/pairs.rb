module Cryptoexchange::Exchanges
  module EtherDelta
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::EtherDelta::Market::API_URL}/returnTicker"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output.keys.map do |pair|
            # format example: ETH_ZRX
            # ETH is the Target, ZRX is the Base
            target, base = pair.split('_')

            Cryptoexchange::Models::MarketPair.new({
              base: base,
              target: target,
              market: EtherDelta::Market::NAME
            })
          end
        end
      end
    end
  end
end
