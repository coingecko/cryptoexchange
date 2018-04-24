module Cryptoexchange::Exchanges
  module Buyucoin
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Buyucoin::Market::API_URL}/currency/markets"


        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output['data'].map do |pair, _value|
            base, target = pair.split('_')
            Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Buyucoin::Market::NAME
            )
          end
        end
      end
    end
  end
end
