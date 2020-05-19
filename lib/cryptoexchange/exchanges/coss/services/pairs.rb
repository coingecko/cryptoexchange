module Cryptoexchange::Exchanges
  module Coss
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Coss::Market::API_URL}/ticker"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output.map do |market_name, _value|
            base, target = market_name.split('_')
            Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Coss::Market::NAME
            )
          end
        end
      end
    end
  end
end
