module Cryptoexchange::Exchanges
  module BitmartFutures
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::BitmartFutures::Market::API_URL}/ifcontract/contracts"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output['data']['contracts'].map do |output|
            output = output['contract']
            base, target = output['base_coin'], output['quote_coin']
            Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              inst_id: output['contract_id'],
              contract_interval: "perpetual",
              market: BitmartFutures::Market::NAME
            )
          end
        end
      end
    end
  end
end
