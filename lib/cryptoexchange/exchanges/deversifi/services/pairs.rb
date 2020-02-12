module Cryptoexchange::Exchanges
  module Deversifi
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Deversifi::Market::API_URL}/v1/trading/r/get/conf"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output["0x"]["exchangeSymbols"].map do |pair|
            pair = pair[1..-1]
            Cryptoexchange::Models::MarketPair.new(
              base: pair[0..2],
              target: pair[3..5],
              market: Deversifi::Market::NAME
            )
          end
        end
      end
    end
  end
end