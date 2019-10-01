module Cryptoexchange::Exchanges
  module Ftx
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Ftx::Market::API_URL}/futures"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          market_pairs = []
          output["result"].each do |pair|
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: pair["underlying"],
                              target: "USD",
                              market: Ftx::Market::NAME,
                              inst_id: pair["name"],
                            )
          end

          market_pairs
        end
      end
    end
  end
end
