module Cryptoexchange::Exchanges
  module Coinhouse
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Coinhouse::Market::API_URL}/tickers"
        TARGET = 'BTC'

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
              base: base,
              target: target,
              market: Coinhouse::Market::NAME
            )
          end
          market_pairs
        end

        def strip_pairs(pair_symbol)
          target = pair_symbol[-3..-1]
          base = pair_symbol.chomp(target)

          [base, target]
        end
      end
    end
  end
end
