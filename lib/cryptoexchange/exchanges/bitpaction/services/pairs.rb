module Cryptoexchange::Exchanges
  module Bitpaction
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Bitpaction::Market::API_URL}/trade/ticks"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output['data'].map do |pair|
            base, target = pair['symbol'].split('-')
            Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Bitpaction::Market::NAME
            )
          end
        end
      end
    end
  end
end
