module Cryptoexchange::Exchanges
  module SaturnNetwork
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::SaturnNetwork::Market::API_URL}/returnTicker.json"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output.map do |pair|
            base = pair[1]["symbol"]
            target, contract_address = pair[0].split('_')

            # skip if it fetch old DGC coin
            next if contract_address == "0x7be3e4849aa2658c91b2d6fcf16ea88cfcb8b41e"

            if base == "NCOV"
              base = "#{base}-#{contract_address}"
            end
            Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              inst_id: contract_address,
              market: SaturnNetwork::Market::NAME,
            )
          end.compact
        end
      end
    end
  end
end
