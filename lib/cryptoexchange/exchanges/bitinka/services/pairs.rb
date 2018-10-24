module Cryptoexchange::Exchanges
  module Bitinka
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Bitinka::Market::API_URL}/ticker?format=json"

        def fetch
          output = super
          market_pairs = []
          output.each do |base, pairs|
            base = base
            pairs.each do |pair|
              target = pair["symbol"].split("_").last

              market_pairs << Cryptoexchange::Models::MarketPair.new(
                                base: base,
                                target: target,
                                market: Cryptoexchange::Exchanges::Bitinka::Market::NAME
                              )
            end
          end

          market_pairs
        end
      end
    end
  end
end
