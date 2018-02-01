module Cryptoexchange::Exchanges
  module Upbit
    module Services
      class Pairs < Cryptoexchange::Services::Pairs

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
                market: Upbit::Market::NAME
              )
          end
          pairs
        end
      end
    end
  end
end
