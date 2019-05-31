module Cryptoexchange::Exchanges
  module DachExchange
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::DachExchange::Market::API_URL}?command=returnTicker"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output.map do |pair, ticker|
            base, target = pair.split("_")

            Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: DachExchange::Market::NAME
            )
          end.compact
        end
      end
    end
  end
end
