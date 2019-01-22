module Cryptoexchange::Exchanges
  module Ginero
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Ginero::Market::API_URL}/market/summary"

        def fetch
          output = super
          market_pairs = []
          output.each do |pair|
            symbol = pair[0].upcase
            base, target = symbol.split(/(VND$)+(.*)/)
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: base,
                              target: target,
                              market: Ginero::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
