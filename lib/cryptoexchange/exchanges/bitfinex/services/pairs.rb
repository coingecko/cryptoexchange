module Cryptoexchange::Exchanges
  module Bitfinex
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Bitfinex::Market::API_URL}/symbols"


        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          market_pairs = []
          output.each do |pair|
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: pair[0..pair.length - 4],
                              target: pair[-3..-1],
                              market: Bitfinex::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
