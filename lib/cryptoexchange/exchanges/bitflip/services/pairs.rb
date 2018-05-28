module Cryptoexchange::Exchanges
  module Bitflip
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Bitflip::Market::API_URL}/market.getPairs"

        def fetch
          output = super
          market_pairs = []
          output[1].each do |pair|
            base, target = pair["pair"].split(':')
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: base,
                              target: target,
                              market: Bitflip::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
