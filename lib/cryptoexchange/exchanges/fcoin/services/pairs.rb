module Cryptoexchange::Exchanges
  module Fcoin
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Fcoin::Market::API_URL}/public/symbols"

        def fetch
          output = super
          adapt(output['data'])
        end

        def adapt(output)
          market_pairs = []
          output.each do |pair|
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: pair['base_currency'],
                              target: pair['quote_currency'],
                              market: Fcoin::Market::NAME
                            )
          end

          market_pairs
        end
      end
    end
  end
end
