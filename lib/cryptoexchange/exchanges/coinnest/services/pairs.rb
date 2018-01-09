module Cryptoexchange::Exchanges
  module Coinnest
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        BASES = ["btc","bt1","bt2","bch","btg","bcd","eth","etc","ada","qtum","xlm","neo","gas","rpx","hsr","knc","tsl","tron","omg","wtc","mco","ink","ent"]

        def fetch
            output = BASES
            adapt(output)
        end

        def adapt(output)
          market_pairs = []
          output.map do |base_asset|
            base = base_asset
            target = "krw"
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: base,
                              target: target,
                              market: Coinnest::Market::NAME
                            )

          end
            market_pairs
        end
      end
    end
  end
end
