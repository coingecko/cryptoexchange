module Cryptoexchange::Exchanges
  module Exrates
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Exrates::Market::API_URL}/ticker"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output.map do |pair|
            base, target = pair["name"].split('_')
            Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target, 
              market: Exrates::Market::NAME
            )
          end.compact
        end
      end
    end
  end
end
