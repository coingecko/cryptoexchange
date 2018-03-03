module Cryptoexchange::Exchanges
  module Lbank
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "http://api.lbank.info/v1/currencyPairs.do"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          market_pairs = []
          output.each do |pair|
           
              base, target = pair.split('_')
              market_pairs << Cryptoexchange::Models::MarketPair.new(
                                base: base.upcase,
                                target: target.upcase,
                                market: Lbank::Market::NAME
                              )
           
          end

          market_pairs
        end
      end
    end
  end
end
