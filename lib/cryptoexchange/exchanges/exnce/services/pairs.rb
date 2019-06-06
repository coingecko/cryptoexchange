module Cryptoexchange::Exchanges
  module Exnce
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Exnce::Market::API_URL}/ticker"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output['data'].map do |pair|
            next unless pair['pair']
            base, target = pair['pair'].split("/")
            Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Exnce::Market::NAME
            )
          end.compact
        end
      end
    end
  end
end
