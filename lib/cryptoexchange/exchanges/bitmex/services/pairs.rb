module Cryptoexchange::Exchanges
  module Bitmex
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Bitmex::Market::API_URL}/instrument/active"
        CONTRACT_INTERVAL_URL = "#{Cryptoexchange::Exchanges::Bitmex::Market::API_URL}/instrument/activeIntervals"

        def fetch
          output = super
          adapt(output)
        end

        def contract_interval
          data = HTTP.get(CONTRACT_INTERVAL_URL).parse(:json)
          intervals = data["intervals"]
          symbols = data["symbols"]
          symbols.zip(intervals)
        end

        def adapt(output)
          contract_intervals = contract_interval
          market_pairs = []
          output.each do |pair|
            x =contract_intervals.find { |i| i[0] == pair["symbol"] }
            ci = if !x.nil?
                    interval = contract_intervals.find { |i| i[0] == pair["symbol"] }[1]
                    interval.split(":")[1]
                  else
                    nil
                  end

            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: pair["rootSymbol"],
                              target: pair["quoteCurrency"],
                              market: Bitmex::Market::NAME,
                              contract_interval: ci,
                              inst_id: pair["symbol"],
                            )
          end

          market_pairs
        end
      end
    end
  end
end
