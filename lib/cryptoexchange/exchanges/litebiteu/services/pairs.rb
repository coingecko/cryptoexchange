module Cryptoexchange::Exchanges
  module Litebiteu
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Litebiteu::Market::API_URL}/markets"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          market_pairs = []

          output['result'].each do |currency, _|

            if currency
              market_pairs << Cryptoexchange::Models::MarketPair.new(
                                base: currency.upcase,
                                target: 'EUR',
                                market: Litebiteu::Market::NAME
                              )
            end
          end

          market_pairs
        end
      end
    end
  end
end
