module Cryptoexchange::Exchanges
  module Digitalprice
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Digitalprice::Market::API_URL}/pairs"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output['data'].map do |pair|
            Cryptoexchange::Models::MarketPair.new(
              base:   pair['quoteSymbol'],
              target: pair['baseSymbol'],
              market: Digitalprice::Market::NAME
            )
          end
        end
      end
    end
  end
end
