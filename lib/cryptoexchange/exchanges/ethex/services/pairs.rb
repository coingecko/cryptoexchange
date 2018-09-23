module Cryptoexchange::Exchanges
  module Ethex
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Ethex::Market::API_URL}/ticker24"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output.map do |pair, _ticker|
            target, base = pair.split('_')
            Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Ethex::Market::NAME
            )
          end
        end
      end
    end
  end
end
