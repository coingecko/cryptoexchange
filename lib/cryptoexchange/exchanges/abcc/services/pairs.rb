module Cryptoexchange::Exchanges
  module Abcc
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Abcc::Market::API_URL}/tickers.json"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output.map do |pair, _ticker|
            separator = /(USDT|BTC|ETH)\z/i =~ pair
            base      = pair[0..separator - 1]
            target    = pair[separator..-1]
            Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Abcc::Market::NAME
            )
          end
        end
      end
    end
  end
end
