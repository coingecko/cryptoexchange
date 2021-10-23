module Cryptoexchange::Exchanges
  module LiquidDerivatives
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::LiquidDerivatives::Market::API_URL}/products?perpetual=1"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output.map do |output|
            base = output["base_currency"].split("-")[1]
            target = output["quoted_currency"]

            Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              inst_id: output["currency_pair_code"],
              contract_interval: output["product_type"].downcase,
              market: LiquidDerivatives::Market::NAME
            )
          end
        end
      end
    end
  end
end
