module Cryptoexchange::Exchanges
  module Mxc
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Mxc::Market::API_URL}/data/markets"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output['data'].map do |pair|
            base, target = pair.split('_')

            Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Mxc::Market::NAME
            )
          end
        end
      end
    end
  end
end
