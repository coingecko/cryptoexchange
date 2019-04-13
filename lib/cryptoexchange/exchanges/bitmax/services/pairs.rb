module Cryptoexchange::Exchanges
  module Bitmax
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Bitmax::Market::API_URL}/products"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output.map do |pair|
            Cryptoexchange::Models::MarketPair.new(
              base:   pair['baseAsset'],
              target: pair['quoteAsset'],
              market: Bitmax::Market::NAME
            )
          end
        end
      end
    end
  end
end
