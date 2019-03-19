module Cryptoexchange::Exchanges
  module Allbit
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Allbit::Market::API_URL}/coin-market-cap-data/"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output.map do |pair, ticker|
            next unless ticker['isFrozen'] == 0
            target, base = pair.split('_')
            Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Allbit::Market::NAME
            )
          end.compact
        end
      end
    end
  end
end
