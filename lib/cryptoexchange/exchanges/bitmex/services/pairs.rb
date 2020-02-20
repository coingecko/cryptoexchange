module Cryptoexchange::Exchanges
  module Bitmex
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Bitmex::Market::API_URL}/instrument/active?reverse=true&count=500"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          market_pairs = []
          output = output.select { |o| o["state"] == "Open" }
          output.each do |pair|
            contract_interval = if pair["typ"] == "FFCCSX"
              "futures"
            elsif pair["typ"] == "FFWCSX"
              "perpetual"
            end

            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: pair["rootSymbol"],
                              target: pair["quoteCurrency"],
                              market: Bitmex::Market::NAME,
                              contract_interval: contract_interval,
                              inst_id: pair["symbol"],
                            )
          end

          market_pairs
        end
      end
    end
  end
end
