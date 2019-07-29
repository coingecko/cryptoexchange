module Cryptoexchange::Exchanges
  module FtxSpot
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::FtxSpot::Market::API_URL}/markets"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          market_pairs = []
          output = output["result"].select { |o| o["type"] == "spot" }
          output.each do |pair|
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: pair["baseCurrency"],
                              target: pair["quoteCurrency"],
                              market: FtxSpot::Market::NAME
                            )
          end

          market_pairs
        end
      end
    end
  end
end
