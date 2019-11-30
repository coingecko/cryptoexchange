module Cryptoexchange::Exchanges
  module Fmex
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Fmex::Market::API_URL}/public/contracts/symbols"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          market_pairs = []
          output["data"].each do |pair|
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: pair["margin_currency"],
                              target: "USD",
                              market: Fmex::Market::NAME,
                              contract_interval: pair["type"],
                              inst_id: pair["name"],
                            )
          end

          market_pairs
        end
      end
    end
  end
end
