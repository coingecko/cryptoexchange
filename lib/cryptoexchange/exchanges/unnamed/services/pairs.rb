module Cryptoexchange::Exchanges
  module Unnamed
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Unnamed::Market::API_URL}/Ticker"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output.map do |pair|
            base, target = pair['market'].split('_')
            Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Unnamed::Market::NAME
            )
          end
        end
      end
    end
  end
end
