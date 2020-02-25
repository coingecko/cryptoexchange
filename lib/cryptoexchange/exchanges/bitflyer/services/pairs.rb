module Cryptoexchange::Exchanges
  module Bitflyer
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Bitflyer::Market::API_URL}/markets"

        def fetch
          jp_pairs = fetch_via_api(jp_markets)
          us_pairs = fetch_via_api(us_markets)
          eu_pairs = fetch_via_api(eu_markets)
          output = jp_pairs + us_pairs + eu_pairs
          adapt(output)
        end

        def jp_markets
          "#{Cryptoexchange::Exchanges::Bitflyer::Market::API_URL}/markets"
        end

        def us_markets
          "#{Cryptoexchange::Exchanges::Bitflyer::Market::API_URL}/markets/usa"
        end

        def eu_markets
          "#{Cryptoexchange::Exchanges::Bitflyer::Market::API_URL}/markets/eu"
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
