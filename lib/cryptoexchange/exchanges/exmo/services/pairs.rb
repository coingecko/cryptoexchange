module Cryptoexchange::Exchanges
  module Exmo
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Exmo::Market::API_URL}/pair_settings"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          pairs = output.keys
          market_pairs = []
          pairs.each do |pair|
            base, target = pair.split('_')
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: base,
                              target: target,
                              market: Exmo::Market::NAME
                            )
          end
          end
          market_pairs
        end
      end
    end
  end
end
