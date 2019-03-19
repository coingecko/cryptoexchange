module Cryptoexchange::Exchanges
  module Kucoin
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Kucoin::Market::API_URL}/symbols"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          pairs = []
          output['data'].each do |data|
            base, target = data['symbol'].split('-')
            pairs << Cryptoexchange::Models::MarketPair.new(
                base: base,
                target: target,
                market: Kucoin::Market::NAME
              )
          end
          pairs
        end
      end
    end
  end
end
