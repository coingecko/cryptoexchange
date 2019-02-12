module Cryptoexchange::Exchanges
  module SaturnNetwork
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::SaturnNetwork::Market::API_URL}/returnTicker.json"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output.map do |pair|
            base = pair[0].split('_').first
            target = pair[1]["symbol"]
            Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: SaturnNetwork::Market::NAME,
            )
          end
        end
      end
    end
  end
end
