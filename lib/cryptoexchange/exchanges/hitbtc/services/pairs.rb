module Cryptoexchange::Exchanges
  module Hitbtc
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Hitbtc::Market::API_URL}/public/symbol"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output.map do |market|
            Cryptoexchange::Models::MarketPair.new({
              base: market['baseCurrency'],
              target: market['quoteCurrency'],
              market: Hitbtc::Market::NAME
            })
          end
        end
      end
    end
  end
end
