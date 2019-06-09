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
          pairs = []
          output['latestPrices'].each do |latestPrices|
            pair = latestPrices['pair']
            base = pair[0..-4]
            target = pair[-3, 3]

            pairs << Cryptoexchange::Models::MarketPair.new(
                base: base,
                target: target,
                market: CoinMetro::Market::NAME
              )
          end
          pairs
        end
      end
    end
  end
end
