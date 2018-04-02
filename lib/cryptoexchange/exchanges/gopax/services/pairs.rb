module Cryptoexchange::Exchanges
  module Gopax
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Gopax::Market::API_URL}/trading-pairs"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          market_pairs = []
          output.each do |pair|
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: pair['baseAsset'],
                              target: pair['quoteAsset'],
                              market: Gopax::Market::NAME
                            )
          end

          market_pairs
        end
      end
    end
  end
end
