module Cryptoexchange::Exchanges
  module TradeSatoshi
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::TradeSatoshi::Market::API_URL}/getmarketsummaries"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          pairs = []
          output['result'].each do |data|
            base, target = data['market'].split('_')
            pairs << Cryptoexchange::Models::MarketPair.new(
                base: base,
                target: target,
                market: TradeSatoshi::Market::NAME
              )
          end
          pairs
        end
      end
    end
  end
end
