module Cryptoexchange::Exchanges
  module RadarRelay
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::RadarRelay::Market::API_URL}/markets"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output.map do |ticker|
            base, target = ticker['displayName'].split('/')
            Cryptoexchange::Models::MarketPair.new({
              base: base,
              target: target,
              market: RadarRelay::Market::NAME
            })
          end
        end
      end
    end
  end
end
