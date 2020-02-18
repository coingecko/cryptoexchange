module Cryptoexchange::Exchanges
  module Xcoex
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Xcoex::Market::API_URL}/ticker"

        def fetch
          output = super
          output.map do |output|
            base, target = Xcoex::Market.separate_symbol(output["Symbol"])
            Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Xcoex::Market::NAME
            )
          end.compact
        end
      end
    end
  end
end
