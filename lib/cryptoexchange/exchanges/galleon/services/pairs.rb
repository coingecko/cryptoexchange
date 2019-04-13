module Cryptoexchange::Exchanges
  module Galleon
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Galleon::Market::API_URL}/tickers.json"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output.map do |pair, ticker|
            base = "grin"
            target = pair.split("grin").last
            Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Galleon::Market::NAME
            )
          end
        end
      end
    end
  end
end
