module Cryptoexchange::Exchanges
  module Coinhouse
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Coinhouse::Market::API_URL}/tickers"
        TARGET    = 'BTC'

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          market_pairs = []
          output.each_key do |pair|
            base, target = strip_pairs(pair)
            next unless base && target
            market_pairs << Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Coinhouse::Market::NAME
            )
          end
          market_pairs
        end

        def strip_pairs(pair_symbol)
          separator = /(USDT|BTC|BCH|ETH)\z/i =~ pair_symbol
          base      = pair_symbol[0..separator - 1]
          target    = pair_symbol[separator..-1]

          [base, target]
        end
      end
    end
  end
end
