module Cryptoexchange::Exchanges
  module Letsdocoinz
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Letsdocoinz::Market::API_URL}/ticker"

        def fetch
          output = super
          market_pairs = []
          output.each do |pair|
            base, target = pair['symbol'].split('-')
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: base,
                              target: target,
                              market: Letsdocoinz::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
