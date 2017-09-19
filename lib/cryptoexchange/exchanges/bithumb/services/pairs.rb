module Cryptoexchange::Exchanges
  module Bithumb
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Bithumb::Market::API_URL}/public/ticker/all"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          pairs = []
          output['data'].keys.each do |base|
            next if base == 'date'
            pairs << Cryptoexchange::Models::MarketPair.new(
                base: base,
                target: 'KRW',
                market: Bithumb::Market::NAME
              )
          end
          pairs
        end
      end
    end
  end
end
