module Cryptoexchange::Exchanges
  module Binance
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Binance::Market::API_URL}/exchangeInfo"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output["symbols"].map do |pair|
            next if pair["status"] != "TRADING"

            base = pair["baseAsset"]
            target = pair["quoteAsset"]
            next unless base && target

            Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Binance::Market::NAME
            )
          end.compact
        end
      end
    end
  end
end
