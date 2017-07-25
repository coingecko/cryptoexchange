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
            base, target = pair.split('_')

            EtherDelta::Models::MarketPair.new({
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
