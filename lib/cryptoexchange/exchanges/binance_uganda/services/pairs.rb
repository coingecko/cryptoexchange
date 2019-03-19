module Cryptoexchange::Exchanges
  module BinanceUganda
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::BinanceUganda::Market::API_URL}/exchangeInfo"

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
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: base,
                              target: target,
                              market: BinanceUganda::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
