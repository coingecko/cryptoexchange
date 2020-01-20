module Cryptoexchange::Exchanges
  module Etorox
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Etorox::Market::API_URL}/snapshot"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output.map do |pair, ticker|
            base, target = pair.split("_")
            Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Etorox::Market::NAME
            )
          end
        end
      end
    end
  end
end
