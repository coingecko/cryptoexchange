module Cryptoexchange::Exchanges
  module Bitmex
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Bitmex::Market::API_URL}/instrument/active?reverse=true&count=500"
        CONTRACT_INTERVAL_URL = "#{Cryptoexchange::Exchanges::Bitmex::Market::API_URL}/instrument/activeIntervals"

        def fetch
          output = super
          adapt(output)
        end

        def contract_intervals
          data = HTTP.get(CONTRACT_INTERVAL_URL).parse(:json)
          intervals = data["intervals"]
          symbols = data["symbols"]
          symbols.zip(intervals)
        end

        def adapt(output)
          prefetch_contract_intervals = contract_intervals
          market_pairs = []
          output = output.select { |o| o["state"] == "Open" }
          output.each do |pair|
            matching_contract = prefetch_contract_intervals.find { |i| i[0] == pair["symbol"] }
            contract_interval = if !matching_contract.nil?
                    matching_contract[1].split(":")[1]
                  else
                    nil
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
