module Cryptoexchange::Exchanges
  module Bitselly
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Bitselly::Market::API_URL}/ticker"

        def fetch
          output = super
          market_pairs = []
          output.each do |pair|
            base, target = pair['symbol'].split('-')
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: base,
                              target: target,
                              market: Bitselly::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
