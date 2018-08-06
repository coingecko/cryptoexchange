module Cryptoexchange::Exchanges
  module Coinchangex
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Coinchangex::Market::API_URL}/returnTicker"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          # fetch token symbol list first
          symbols = Cryptoexchange::Exchanges::Coinchangex::Market.fetch_symbol
          output.map do |key, value|
            base   = symbols[value['tokenAddr']]
            next if base.nil?
            target = key.split('_').first
            Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Coinchangex::Market::NAME
            )
          end.compact
        end
      end
    end
  end
end
