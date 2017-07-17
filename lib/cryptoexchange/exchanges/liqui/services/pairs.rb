module Cryptoexchange::Exchanges
  module Liqui
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Liqui::Market::API_URL}/info"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          market_pairs = []
          output['pairs'].keys.map do |pair|
            base, target = pair.upcase.split('_')

            Liqui::Models::MarketPair.new({
              base: base,
              target: target,
              market: Liqui::Market::NAME
            })
          end
        end
      end
    end
  end
end
