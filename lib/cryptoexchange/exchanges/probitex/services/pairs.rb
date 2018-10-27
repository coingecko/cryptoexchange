module Cryptoexchange::Exchanges
  module Probitex
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Probitex::Market::API_URL}/get_market_all"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output['data'].map do |pair, _ticker|
            base, target = pair.split('_')
            Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Probitex::Market::NAME
            )
          end
        end
      end
    end
  end
end
