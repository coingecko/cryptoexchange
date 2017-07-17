module Cryptoexchange::Exchanges
  module Gemini
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Gemini::Market::API_URL}/symbols"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          market_pairs = []
            output.each do |pair|
            base =
            target = pair[3..-1]
            market_pairs << Gemini::Models::MarketPair.new(
                              base: pair[0..2],
                              target: pair[3..-1],
                              market: Gemini::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
