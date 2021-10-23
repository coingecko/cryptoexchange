module Cryptoexchange::Exchanges
  module FtxUs
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::FtxUs::Market::API_URL}/markets"

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
                              market: FtxUs::Market::NAME
                            )
          end

          market_pairs
        end
      end
    end
  end
end
