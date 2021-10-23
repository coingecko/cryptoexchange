module Cryptoexchange::Exchanges
  module DeltaFutures
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::DeltaFutures::Market::API_URL}/products"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output.map do |pair|
            base, target = pair["underlying_asset"]['symbol'], pair["quoting_asset"]['symbol']
            inst_id = pair['symbol']
            Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              contract_interval: pair['contract_type'].split("_").first,
              inst_id: inst_id,
              market: DeltaFutures::Market::NAME
            )
          end
        end
      end
    end
  end
end
