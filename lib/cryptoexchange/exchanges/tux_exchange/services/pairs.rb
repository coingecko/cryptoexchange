module Cryptoexchange::Exchanges
  module TuxExchange
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::TuxExchange::Market::API_URL}?method=getticker"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          market_pairs = []
          output.each_key do |pairs|
            target, base = pairs.split("_")
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: base,
                              target: target,
                              market: TuxExchange::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
