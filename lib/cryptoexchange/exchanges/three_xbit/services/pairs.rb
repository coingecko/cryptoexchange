module Cryptoexchange::Exchanges
  module ThreeXbit
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::ThreeXbit::Market::API_URL}/ticker/"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output.map do |pair, _ticker|
            raw_target, base = pair.split('_')
            target = raw_target == 'CREDIT' ? 'USD' : raw_target
            Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: ThreeXbit::Market::NAME
            )
          end
        end
      end
    end
  end
end
