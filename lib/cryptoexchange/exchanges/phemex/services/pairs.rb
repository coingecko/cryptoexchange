module Cryptoexchange::Exchanges
  module Phemex
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Phemex::Market::API_URL}/ticker/24hr/all"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output["result"].map do |output|
            base, target = Phemex::Market.separate_symbol(output["symbol"])

            Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              inst_id: output["symbol"],
              contract_interval: "perpetual",
              market: Phemex::Market::NAME
            )
          end.compact
        end
      end
    end
  end
end
