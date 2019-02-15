module Cryptoexchange::Exchanges
  module Vinex
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Vinex::Market::API_URL}/markets"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output["data"].map do |output|
            target, base = output['symbol'].split("_")
            Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Vinex::Market::NAME
            )
          end
        end
      end
    end
  end
end
