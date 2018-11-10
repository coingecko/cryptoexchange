module Cryptoexchange::Exchanges
  module Bitrabbit
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Bitrabbit::Market::API_URL}/tickets"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output.map do |pair, ticker|
            next unless ticker['isFrozen'] == '0'
            base, target = pair.split('_')
            Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Bitrabbit::Market::NAME
            )
          end.compact
        end
      end
    end
  end
end
