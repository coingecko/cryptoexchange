module Cryptoexchange::Exchanges
  module Aax
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Aax::Market::API_URL}/tickers"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output["tickers"].map do |output|
            base, target = Abcc::Market.separate_symbol(output["s"])
            next if base == nil
            Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Aax::Market::NAME
            )
          end.compact
        end
      end
    end
  end
end
