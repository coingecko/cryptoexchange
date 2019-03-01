module Cryptoexchange::Exchanges
  module Tradesprite
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Tradesprite::Market::API_URL}/ticks"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output['data'].map do |_symbol, pairs|
            pairs['stats'].map do |key, _value|
              base, target = key.split('-')
              Cryptoexchange::Models::MarketPair.new(
                base:   base,
                target: target,
                market: Tradesprite::Market::NAME
              )
            end
          end.flatten
        end
      end
    end
  end
end
