module Cryptoexchange::Exchanges
  module Novadax
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
       PAIRS_URL = "#{Cryptoexchange::Exchanges::Novadax::Market::API_URL}/data/market"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output['data'].map do |pair|
            Cryptoexchange::Models::MarketPair.new(
              base: pair,
              target: 'BRL',
              market: Novadax::Market::NAME
            )
          end
        end
      end
    end
  end
end
