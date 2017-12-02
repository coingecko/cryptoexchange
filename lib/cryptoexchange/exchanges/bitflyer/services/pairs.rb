module Cryptoexchange::Exchanges
  module Bitflyer
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Bitflyer::Market::API_URL}/markets"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          market_pairs = []
          output.each do |value|

            product_code = value['product_code']

            if product_code =~ /\A[A-Z]{3}_[A-Z]{3}\z/
              base, target = product_code.split('_')
              market_pairs << Cryptoexchange::Models::MarketPair.new(
                                base: base,
                                target: target,
                                market: Bitflyer::Market::NAME
                              )
            end
          end

          market_pairs
        end
      end
    end
  end
end
