module Cryptoexchange::Exchanges
  module Coindcx
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Coindcx::Market::API_URL}/exchange/ticker"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output.map do |pair|
            next unless pair["market"].chars.last(3).join == "INR"
            base, target = Coindcx::Market.separate_symbol(pair["market"])
            Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Coindcx::Market::NAME
            )
          end.compact
        end
      end
    end
  end
end
