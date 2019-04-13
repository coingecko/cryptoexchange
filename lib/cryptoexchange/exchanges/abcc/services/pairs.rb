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
            base, target = Abcc::Market.separate_symbol(pair)
            next if base.nil? || target.nil?

            Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Abcc::Market::NAME
            )
          end.compact
        end
      end
    end
  end
end
