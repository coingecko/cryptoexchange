module Cryptoexchange::Exchanges
  module BitflyerFutures
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::BitflyerFutures::Market::API_URL}/markets"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          market_pairs = []
          output.each do |value|

            product_code = value['product_code']
            if product_code.include?("FX")
              base, target = product_code.split('_').delete_if { |x| x == "FX" }
              market_pairs << Cryptoexchange::Models::MarketPair.new(
                                base: base,
                                target: target,
                                market: BitflyerFutures::Market::NAME
                              )
            end
          end

          market_pairs
        end
      end
    end
  end
end
