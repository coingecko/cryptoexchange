module Cryptoexchange::Exchanges
  module KrakenFutures
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::KrakenFutures::Market::API_URL}/tickers"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output['tickers'].map do |output|
            if output.key?("pair")
              base, target = output["pair"].split(":")

              next if target != "USD"
              # skipping non USD pair because volume reported is mixed (some in base, some in target)

              Cryptoexchange::Models::MarketPair.new(
                base: base,
                target: target,
                inst_id: output["symbol"],
                market: KrakenFutures::Market::NAME,
                contract_interval: output["tag"],
              )
            end
          end.compact
        end
      end
    end
  end
end
