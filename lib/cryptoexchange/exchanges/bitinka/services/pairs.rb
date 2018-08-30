module Cryptoexchange::Exchanges
  module Bitinka
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Bitinka::Market::API_URL}/ticker?format=json"

        def fetch
          output = super
          market_pairs = []
          output.each do |pair|
            base, target =  pair[1]['volumen24hours'].keys
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: base,
                              target: target,
                              market: Bitinka::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
