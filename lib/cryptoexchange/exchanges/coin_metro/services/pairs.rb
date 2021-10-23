module Cryptoexchange::Exchanges
  module CoinMetro
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::CoinMetro::Market::API_URL}/prices"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output["latestPrices"].map do |ticker|
            pair = ticker["pair"]
            separator = /(BTC|ETH|EUR)\z/i =~ pair

            base      = pair[0..separator - 1]
            target    = pair[separator..-1]

            next if base.nil? || target.nil?

            Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: CoinMetro::Market::NAME
            )
          end.compact
        end
      end
    end
  end
end
