module Cryptoexchange::Exchanges
  module Cezex
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Cezex::Market::API_URL}/markets"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output.map do |market|
            Cryptoexchange::Models::MarketPair.new({
              base: market['name'].split("/")[0],
              target: market['name'].split("/")[1],
              market: Cezex::Market::NAME
            })
          end
        end
      end
    end
  end
end

