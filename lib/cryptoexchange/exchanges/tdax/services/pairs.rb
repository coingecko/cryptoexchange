module Cryptoexchange::Exchanges
  module Tdax
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Tdax::Market::API_URL}/marketcap/"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output.map do |pair, _ticker|
            base, target = pair.split('_')
            Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Tdax::Market::NAME
            )
          end
        end
      end
    end
  end
end
