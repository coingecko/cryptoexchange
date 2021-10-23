module Cryptoexchange::Exchanges
  module Bitci
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Bitci::Market::API_URL}/ReturnTicker"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          market_pairs = []
          output.each do |pair|
            base, target = pair["CoinCode"], pair["CurrencyCode"]
            market_pairs <<
            Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Bitci::Market::NAME
            )
          end
          market_pairs
        end
      end
    end
  end
end
