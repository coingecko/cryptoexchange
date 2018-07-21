module Cryptoexchange::Exchanges
  module Bitliber
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Bitliber::Market::API_URL}/public/pairs"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output['result'].map do |pair|
            Cryptoexchange::Models::MarketPair.new(
              base: pair['baseCurrency'],
              target: pair['quoteCurrency'],
              market: Bitliber::Market::NAME
            )
          end
        end
      end
    end
  end
end