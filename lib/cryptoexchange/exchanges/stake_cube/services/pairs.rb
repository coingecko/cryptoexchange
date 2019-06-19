module Cryptoexchange::Exchanges
  module StakeCube
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::StakeCube::Market::API_URL}/exchange/tickers"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output.map do |pair|
            Cryptoexchange::Models::MarketPair.new(
              base: pair['target'],
              target: pair['base'],
              market: StakeCube::Market::NAME
            )
          end
        end
      end
    end
  end
end
