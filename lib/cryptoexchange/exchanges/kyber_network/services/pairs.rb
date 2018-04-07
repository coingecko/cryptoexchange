module Cryptoexchange::Exchanges
  module KyberNetwork
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::KyberNetwork::Market::API_URL}/currencies/convertiblePairs"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          market_pairs = []
          output.keys.each do |pair|
            target, base = pair.split '_'
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: base,
                              target: target,
                              market: KyberNetwork::Market::NAME
                            )
          end

          market_pairs
        end
      end
    end
  end
end
