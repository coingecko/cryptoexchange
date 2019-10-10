module Cryptoexchange::Exchanges
  module BitzFutures
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::BitzFutures::Market::API_URL}/Market/getContractTickers"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          market_pairs = []
          pairs = output["data"]
          pairs.each do |pair|
            base, target = pair['pair'].split("_")
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: base,
                              target: target,
                              inst_id: pair['contractId'],
                              contract_interval: "perpetual",
                              market: BitzFutures::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
