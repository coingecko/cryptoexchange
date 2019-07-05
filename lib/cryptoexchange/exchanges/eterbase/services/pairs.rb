module Cryptoexchange::Exchanges
  module Eterbase
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Eterbase::Market::API_URL}/markets"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          market_pairs = []
          output.each do |pair|
            base, target = pair['base'], pair['quote']
            market_pairs <<
            Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              inst_id: pair['id'],
              market: Eterbase::Market::NAME
            )
          end
          market_pairs
        end
      end
    end
  end
end
