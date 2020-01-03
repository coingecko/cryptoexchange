module Cryptoexchange::Exchanges
  module Vitex
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Vitex::Market::API_URL}/ticker/24hr"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output["data"].map do |ticker|
            Cryptoexchange::Models::MarketPair.new(
              base:   ticker["tradeTokenSymbol"],
              target: ticker["quoteTokenSymbol"],
              market: Vitex::Market::NAME
            )
          end
        end
      end
    end
  end
end
