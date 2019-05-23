module Cryptoexchange::Exchanges
  module Mxc
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Mxc::Market::API_URL}/open/api/v1/data/ticker"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output["data"].map do |pair, _ticker|
            base, target = pair.split('_')
            Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Mxc::Market::NAME
            )
          end
        end
      end
    end
  end
end
