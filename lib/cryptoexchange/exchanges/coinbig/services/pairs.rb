module Cryptoexchange::Exchanges
  module Coinbig
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Coinbig::Market::API_URL}/symbols"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output["data"].map do |pair|
            base, target = pair.split('_')
            Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Coinbig::Market::NAME
            )
          end
        end
      end
    end
  end
end
