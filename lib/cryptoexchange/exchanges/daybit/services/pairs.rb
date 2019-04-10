module Cryptoexchange::Exchanges
  module Daybit
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Daybit::Market::API_URL}"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output['data'].map do |pair|
            base, target = pair['base'], pair['quote']
            Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Daybit::Market::NAME
            )
          end
        end
      end
    end
  end
end
