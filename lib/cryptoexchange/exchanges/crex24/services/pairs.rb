module Cryptoexchange::Exchanges
  module Crex24
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Crex24::Market::API_URL}/tickers"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output.map do |pair|
            base, target = pair['instrument'].split("-")
            Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Crex24::Market::NAME
            )
          end
        end
      end
    end
  end
end
