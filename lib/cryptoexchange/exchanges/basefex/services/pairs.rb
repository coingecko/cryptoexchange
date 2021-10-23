module Cryptoexchange::Exchanges
  module Basefex
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Basefex::Market::API_URL}/instruments"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output.map do |pair|
            next unless pair
            base, target = Basefex::Market.separate_symbol(pair["symbol"])
            Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              inst_id: pair["symbol"],
              contract_interval: "perpetual",
              market: Basefex::Market::NAME
            )
          end
        end
      end
    end
  end
end
