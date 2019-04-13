module Cryptoexchange::Exchanges
  module Graviex
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Graviex::Market::API_URL}/markets"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output.map do |market|
            Cryptoexchange::Models::MarketPair.new({
              base: market['name'].split("/")[0].gsub("$", ""),
              target: market['name'].split("/")[1],
              market: Graviex::Market::NAME
            })
          end
        end
      end
    end
  end
end
