module Cryptoexchange::Exchanges
  module Codex
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Codex::Market::API_URL}/coins2/market"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          pairs = output
          pairs.map do |pair|
            Cryptoexchange::Models::MarketPair.new(
                base: pair['base_currency']['code'],
                target: pair['quote_currency']['code'],
                market: Codex::Market::NAME
            )
          end
        end
      end
    end
  end
end
