module Cryptoexchange::Exchanges
  module Coinfinit
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Coinfinit::Market::API_URL}/ticker"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output["market"].map do |pair, ticker|
            target, base = pair.split("_")
            Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Coinfinit::Market::NAME
            )
          end
        end
      end
    end
  end
end
