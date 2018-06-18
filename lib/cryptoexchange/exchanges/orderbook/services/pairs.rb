module Cryptoexchange::Exchanges
  module Orderbook
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Orderbook::Market::API_URL}/info/ticker"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          market_pairs = []
          output.each do |pair|
            base, target = pair[0].split('-')
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: base,
                              target: target,
                              market: Orderbook::Market::NAME
                            )
          end

          market_pairs
        end
      end
    end
  end
end
