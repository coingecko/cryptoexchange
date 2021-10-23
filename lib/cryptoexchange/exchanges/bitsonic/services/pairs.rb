module Cryptoexchange::Exchanges
  module Bitsonic
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Bitsonic::Market::API_URL}/external/ticker/all"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          market_pairs = []
          output["result"].each do |pair|
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: pair["symbol"],
                              target: pair["market"],
                              market: Bitsonic::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
