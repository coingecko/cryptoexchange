module Cryptoexchange::Exchanges
  module Sistemkoin
    module Services
      class Pairs < Cryptoexchange::Services::Pairs

        PAIRS_URL = "#{Cryptoexchange::Exchanges::Sistemkoin::Market::API_URL}/ticker"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output['data'].map do |based, pair|
            pair.map do |pair|
              Cryptoexchange::Models::MarketPair.new(
                base: pair['short_code'],
                target: pair['currency'],
                market: Sistemkoin::Market::NAME)
            end
          end
        end
      end
    end
  end
end