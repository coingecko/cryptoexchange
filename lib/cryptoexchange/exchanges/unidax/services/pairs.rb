module Cryptoexchange::Exchanges
  module Unidax
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Unidax::Market::API_URL}/common/symbols"

        def fetch
          output = super
          market_pairs = []
          output["data"].each do |pair|
            target, base = pair["count_coin"], pair["base_coin"]
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: base,
                              target: target,
                              market: Unidax::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
