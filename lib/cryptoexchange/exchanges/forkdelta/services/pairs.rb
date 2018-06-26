module Cryptoexchange::Exchanges
  module Forkdelta
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Forkdelta::Market::API_URL}/returnTicker"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          # fetch token symbol list first
          symbols = Cryptoexchange::Exchanges::Forkdelta::Market.fetch_symbol
          output.map do |key, value|
            base   = symbols[value['tokenAddr']]
            next if base.nil?
            target = key.split('_').first
            Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Forkdelta::Market::NAME
            )
          end.compact
        end
      end
    end
  end
end
