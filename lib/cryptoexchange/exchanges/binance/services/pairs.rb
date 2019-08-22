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
          market_pairs = []
          output["symbols"].each do |pair|
            base = pair["baseAsset"]
            target = pair["quoteAsset"]
            next unless base && target
            next if pair["status"] != "TRADING"
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: base,
                              target: target,
                              market: Binance::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
