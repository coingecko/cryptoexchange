module Cryptoexchange::Exchanges
  module Hopex
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Hopex::Market::API_URL}/markets"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output['data'].map do |pair|
            base = pair["contractName"].split("/")[0]
            target = pair["quotedCurrency"]
            inst_id = pair['contractCode']
            Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              contract_interval: 'perpetual',
              inst_id: inst_id,
              market: Hopex::Market::NAME
            )
          end
        end
      end
    end
  end
end
