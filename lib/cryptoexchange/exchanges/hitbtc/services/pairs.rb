module Cryptoexchange::Exchanges
  module Hitbtc
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Hitbtc::Market::API_URL}/public/symbols"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output['symbols'].map do |market|
            Hitbtc::Models::MarketPair.new({
              base: market['commodity'],
              target: market['currency'],
              market: Hitbtc::Market::NAME
            })
          end
        end
      end
    end
  end
end
