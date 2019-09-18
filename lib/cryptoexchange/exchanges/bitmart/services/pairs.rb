module Cryptoexchange::Exchanges
  module Bitmart
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Bitmart::Market::API_URL}/symbols_details"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          market_pairs = []
          output.each do |value|
            base, target = value['base_currency'], value['quote_currency']
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                    base: base,
                    target: target,
                    market: Bitmart::Market::NAME
                  )
          end

          market_pairs
        end
      end
    end
  end
end
