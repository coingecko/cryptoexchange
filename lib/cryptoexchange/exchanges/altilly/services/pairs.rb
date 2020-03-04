module Cryptoexchange::Exchanges
  module Altilly
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Altilly::Market::API_URL}/public/ticker"

        def fetch
          output = super
          output.map do |ticker|
            base, target = Cryptoexchange::Exchanges::Altilly::Market.separate_symbol(ticker["symbol"])
            Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Altilly::Market::NAME
            )
          end.compact
        end
      end
    end
  end
end
