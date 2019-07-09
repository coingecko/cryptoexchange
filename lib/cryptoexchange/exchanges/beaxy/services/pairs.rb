module Cryptoexchange::Exchanges
  module Beaxy
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Beaxy::Market::API_URL}/Symbols"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output.map do |pair|
            base, target = pair["n"].split("-")
            inst_id = pair['sb']
            Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              inst_id: inst_id,
              market: Beaxy::Market::NAME
            )
          end
        end
      end
    end
  end
end
