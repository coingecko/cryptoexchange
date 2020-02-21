module Cryptoexchange::Exchanges
  module Etorox
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Etorox::Market::API_URL}/tickers"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output["instruments"].map do |ticker|
            base, target = Etorox::Market.separate_symbol(ticker["id"])
            next if base.nil? || target.nil?

            Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Etorox::Market::NAME
            )
          end.compact
        end
      end
    end
  end
end
