module Cryptoexchange::Exchanges
  module Dobitrade
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Dobitrade::Market::API_URL}/trade/markets"

        def fetch
          output = super
          adapt(output["data"])
        end

        def adapt(output)
          market_pairs = []
          output.each do |value|
              base, target = value.split('_')
              market_pairs << Cryptoexchange::Models::MarketPair.new(
                                base: base.upcase,
                                target: target.upcase,
                                market: Dobitrade::Market::NAME
                              )
          end

          market_pairs
        end
      end
    end
  end
end
