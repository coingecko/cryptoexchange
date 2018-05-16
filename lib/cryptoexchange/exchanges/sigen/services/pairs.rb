module Cryptoexchange::Exchanges
  module Sigen
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Sigen::Market::API_URL}/ticker"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output['data']['ticker'].map do |pair, ticker|
            base, target = pair.split("_")
            Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Sigen::Market::NAME
            )
          end
        end
      end
    end
  end
end
