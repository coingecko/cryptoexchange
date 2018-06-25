module Cryptoexchange::Exchanges
  module Koinex
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Koinex::Market::API_URL}/ticker"

        def fetch
          output = super
          adapt(output["prices"])
        end

        def adapt(output)
          market_pairs = []
          output.each do |target_raw|
            target = GetSymbol.get_symbol(target_raw[0])
            target_raw[1].each do |base|
              market_pairs << Cryptoexchange::Models::MarketPair.new(
                                base: base[0],
                                target: target,
                                market: Koinex::Market::NAME
                              )
            end
          end
          market_pairs
        end
      end
    end
  end
end
