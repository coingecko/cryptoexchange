module Cryptoexchange::Exchanges
  module Ccex
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Ccex::Market::API_URL}/pairs.json"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output['pairs'].map do |pair|
            base, target = pair.upcase.split('-')

            Cryptoexchange::Models::MarketPair.new({
              base: base,
              target: target,
              market: Ccex::Market::NAME
            })
          end
        end
      end
    end
  end
end
