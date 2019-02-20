module Cryptoexchange::Exchanges
  module Dflow
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Dflow::Market::API_URL}/market/list"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output['data'].map do |output|
            base = output["base_coin"]
            target = output["count_coin"]
            Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Dflow::Market::NAME
            )
          end
        end
      end
    end
  end
end
