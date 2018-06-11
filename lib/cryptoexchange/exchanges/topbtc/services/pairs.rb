module Cryptoexchange::Exchanges
  module Topbtc
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Topbtc::Market::API_URL}"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output.map do |pair|
            base = pair['coin']
            target = pair['market']
            Cryptoexchange::Models::MarketPair.new({
              base: base,
              target: target,
              market: Topbtc::Market::NAME
            })
          end
        end
      end
    end
  end
end
