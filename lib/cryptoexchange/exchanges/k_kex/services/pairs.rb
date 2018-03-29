module Cryptoexchange::Exchanges
  module KKex
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::KKex::Market::API_URL}/products"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output["products"].map do |pair|
            Cryptoexchange::Models::MarketPair.new(
              base:   pair['mark_asset'],
              target: pair['base_asset'],
              market: KKex::Market::NAME
            )
          end
        end
      end
    end
  end
end
