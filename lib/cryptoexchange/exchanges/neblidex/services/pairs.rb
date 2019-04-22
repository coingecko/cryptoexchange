module Cryptoexchange::Exchanges
  module Neblidex
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Neblidex::Market::API_URL}"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output.map do |pair|
            base = pair['baseAsset']
            target = pair['tradeAsset']
            Cryptoexchange::Models::MarketPair.new({
              base: base,
              target: target,
              market: Neblidex::Market::NAME
            })
          end
        end
      end
    end
  end
end
