module Cryptoexchange::Exchanges
  module Bitmesh
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Bitmesh::Market::API_URL}"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          pairs = output
          market_pairs = []
          pairs["data"].each do |pair, value|
            unless value['price'].nil?
              target, base = pair.split('_')
              market_pairs <<
              Cryptoexchange::Models::MarketPair.new(
                base: base,
                target: target,
                market: Bitmesh::Market::NAME
              )
            end
          end

          market_pairs
        end
      end
    end
  end
end
