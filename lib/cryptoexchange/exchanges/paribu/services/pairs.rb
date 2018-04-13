module Cryptoexchange::Exchanges
  module Paribu
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "https://www.paribu.com/ticker"

        def fetch
          output = super
          market_pairs = []
          output.keys.each do |pair|
          base, target = pair.split("_")
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: base,
                              target: target,
                              market: Paribu::Market::NAME
                            )
           end
          market_pairs
        end
      end
    end
  end
end
