module Cryptoexchange::Exchanges
  module Gbx
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Gbx::Market::API_URL}/market/hour24Market"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          puts output
          output['data'].map do |pair, ticker|
            next if ticker['isFrozen'] == 1
            base, target = pair.split('/')
            Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Gbx::Market::NAME
            )
          end.compact
        end
      end
    end
  end
end
