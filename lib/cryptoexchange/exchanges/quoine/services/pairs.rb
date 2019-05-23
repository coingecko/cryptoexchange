module Cryptoexchange::Exchanges
  module Quoine
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Quoine::Market::API_URL}/products"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          market_pairs = []
          output.each do |pair|
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: pair['base_currency'],
                              target: pair['quoted_currency'],
                              market: Quoine::Market::NAME,
                              inst_id: pair['id'],
                            )
          end
          market_pairs
        end
      end
    end
  end
end
