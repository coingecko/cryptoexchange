module Cryptoexchange::Exchanges
  module Tokenlon
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Tokenlon::Market::API_URL}/get_market"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output['data'].map do |pair|
            base, target = pair["pairs"].split('_')
            Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Tokenlon::Market::NAME
            )
          end
        end
      end
    end
  end
end
