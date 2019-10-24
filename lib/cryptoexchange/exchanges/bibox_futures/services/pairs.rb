module Cryptoexchange::Exchanges
  module BiboxFutures
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::BiboxFutures::Market::API_URL}/mdata?cmd=pairList"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output['result'].map do |pair|
            next if pair["pair_type"] != 4
            base, target = pair["pair"].tr("0-9", "").split("_")
            Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              inst_id: pair["pair"],
              contract_interval: "perpetual",
              market: BiboxFutures::Market::NAME
            )
          end.compact
        end
      end
    end
  end
end
