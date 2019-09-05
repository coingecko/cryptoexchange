module Cryptoexchange::Exchanges
  module BtseFutures
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::BtseFutures::Market::API_URL}/market_summary"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output.map do |ticker|
            base = ticker["symbol"].chomp("PFC") 
            target = "USD"
            inst_id = ticker["symbol"]
            contract_interval = "Perpetual"

            Cryptoexchange::Models::MarketPair.new({
              base: base,
              target: target,
              inst_id: inst_id,
              contract_interval: contract_interval,
              market: BtseFutures::Market::NAME
            })
          end
        end
      end
    end
  end
end
