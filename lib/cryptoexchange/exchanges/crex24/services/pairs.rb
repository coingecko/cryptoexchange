module Cryptoexchange::Exchanges
  module Crex24
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Crex24::Market::API_URL}/ReturnTicker"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output['Tickers'].collect do |pair|
            target, base = pair['PairName'].split("_")
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
