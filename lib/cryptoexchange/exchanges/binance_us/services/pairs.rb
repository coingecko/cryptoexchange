module Cryptoexchange::Exchanges
  module BinanceUs
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::BinanceUs::Market::API_URL}/exchangeInfo"

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
              market: BinanceUs::Market::NAME
            )
          end.compact
        end
      end
    end
  end
end
