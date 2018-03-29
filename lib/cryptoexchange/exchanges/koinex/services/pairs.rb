module Cryptoexchange::Exchanges
  module Koinex
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Koinex::Market::API_URL}/ticker"

        def fetch
          output = super
          adapt(output["prices"])
        end

        def adapt(output)
          market_pairs = []
          output.each do |currency, price|
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: currency,
                              target: "INR",
                              market: Koinex::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
