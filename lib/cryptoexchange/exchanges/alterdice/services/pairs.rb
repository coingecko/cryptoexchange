module Cryptoexchange::Exchanges
  module Alterdice
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Alterdice::Market::API_URL}/symbols"


        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          market_pairs = []
          output.each do |pair|
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: pair[0..2],
                              target: pair[3..-1],
                              market: Alterdice::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
